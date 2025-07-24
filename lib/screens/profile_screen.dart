import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:giziku/providers/profile_provider.dart';
import 'package:giziku/screens/edit_profile_screen.dart';
import 'package:giziku/models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch profile data when screen initializes
    Future.microtask(() => 
      Provider.of<ProfileProvider>(context, listen: false).fetchUserProfile()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final isLoading = profileProvider.isLoading;
        final userProfile = profileProvider.userProfile;
        
        if (isLoading && userProfile == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2ECC71),
              ),
            ),
          );
        }
        
        return Scaffold(
          body: Column(
            children: [
              _buildHeader(userProfile),
              
              _buildProfileMenuList(),

              _buildLogoutButton(),
            ],
          ),
        );
      }
    );
  }

  Widget _buildHeader(UserProfile? userProfile) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF2ECC71),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Email dan nama
          Positioned(
            top: 60,
            child: Column(
              children: [
                Text(
                  userProfile?.name ?? 'User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userProfile?.email ?? 'user@example.com',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          
          // Foto profil
          Positioned(
            bottom: -40,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.yellow,
                    backgroundImage: userProfile?.photoUrl != null 
                        ? NetworkImage(userProfile!.photoUrl!) as ImageProvider
                        : const AssetImage('assets/profile/profile.png'),
                    child: userProfile?.photoUrl == null
                      ? const Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.blue,
                      )
                      : null,
                  ),
                  
                  // Edit icon on bottom-right of the avatar
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Color(0xFF2ECC71),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Back button
          Positioned(
            top: 40,
            left: 20,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          
          // Notification button
          Positioned(
            top: 40,
            right: 20,
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuList() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _buildMenuItem(
              title: 'My Profile',
              icon: 'assets/profile/profile.png',
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const EditProfileScreen())
                );
              },
            ),
            _buildMenuItem(
              title: 'Like',
              icon: 'assets/profile/like.png',
              onTap: () {},
            ),
            _buildMenuItem(
              title: 'Recommendation',
              icon: 'assets/profile/recommendation.png',
              onTap: () {},
            ),
            _buildMenuItem(
              title: 'Faq',
              icon: 'assets/profile/faq.png',
              onTap: () {},
            ),
            _buildMenuItem(
              title: 'About',
              icon: 'assets/profile/about.png',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title, 
    required String icon, 
    required VoidCallback onTap
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            // Icon in a circle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: title == 'My Profile' ? const Color(0xFFD4D4FC) : 
                      title == 'Like' ? const Color(0xFFFFD1D1) :
                      title == 'Recommendation' ? const Color(0xFFADE0FF) :
                      title == 'Faq' ? const Color(0xFF9BFFD0) :
                      const Color(0xFFE3D1FF),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  icon,
                  color: title == 'My Profile' ? Colors.indigo : 
                       title == 'Like' ? Colors.red :
                       title == 'Recommendation' ? Colors.blue :
                       title == 'Faq' ? const Color(0xFF2ECC71) :
                       Colors.purple,
                ),
              ),
            ),
            
            const SizedBox(width: 15),
            
            // Menu title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Logout logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2ECC71),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
