import 'package:flutter/material.dart';
import 'package:giziku/screens/profiles/about_screen.dart';
import 'package:giziku/screens/profiles/faq_screen.dart';
import 'package:giziku/screens/profiles/profile_detail_screen.dart';
import 'package:giziku/screens/profiles/shop_profile_screen.dart';
import 'package:giziku/screens/profiles/family_member_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final String name = user?.displayName ?? "Guest User";
    final String email = user?.email ?? "No Email";
    final String? photoUrl = user?.photoURL;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Column(
            children: [
              // ================= HEADER =================
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,

                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 24,
                      right: 24,
                      bottom: 90,
                    ),

                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2AD882), Color(0xFF2ECC71)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),

                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),

                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        const Text(
                          "My Profile",
                          style: TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 10),

                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,

                          backgroundImage: photoUrl != null
                              ? NetworkImage(photoUrl)
                              : const AssetImage('assets/profile/profile.png')
                                    as ImageProvider,
                        ),

                        const SizedBox(height: 14),

                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Poppins',
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ================= STATS CARD =================
                  Positioned(
                    bottom: -45,

                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          _StatItem(value: "3", label: "Members"),

                          _DividerVertical(),

                          _StatItem(value: "92%", label: "Healthy"),

                          _DividerVertical(),

                          _StatItem(value: "12", label: "Recipes"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),

              // ================= FAMILY MEMBERS =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          "Family Members",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextButton(
                          onPressed: () {},

                          child: const Text(
                            "See All",
                            style: TextStyle(
                              color: Color(0xFF2ECC71),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      height: 130,

                      child: ListView(
                        scrollDirection: Axis.horizontal,

                        children: [
                          _familyCard(
                            context: context,
                            name: "Jenny",
                            role: "Mother",
                            color: const Color(0xFFE8FFF1),
                          ),

                          _familyCard(
                            context: context,
                            name: "Bagas",
                            role: "Father",
                            color: const Color(0xFFEAF2FF),
                          ),

                          _familyCard(
                            context: context,
                            name: "Rara",
                            role: "Child",
                            color: const Color(0xFFFFF4E5),
                          ),

                          _addMemberCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ================= MENU =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),

                child: Column(
                  children: [
                    _ProfileMenuItem(
                      icon: Icons.person_outline,
                      label: 'My Profile',
                      color: const Color(0xFFEEF2FF),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileDetailScreen(),
                          ),
                        );
                      },
                    ),

                    _ProfileMenuItem(
                      icon: Icons.groups_2_outlined,
                      label: 'Family Members',
                      color: const Color(0xFFE8FFF1),

                      onTap: () {},
                    ),

                    _ProfileMenuItem(
                      icon: Icons.restaurant_menu_outlined,
                      label: 'Nutrition History',
                      color: const Color(0xFFFFF4E5),

                      onTap: () {},
                    ),

                    _ProfileMenuItem(
                      icon: Icons.help_outline,
                      label: 'FAQ',
                      color: const Color(0xFFDFF7FF),

                      onTap: () { 
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FAQScreen()),
                        );
                      },
                    ),

                    _ProfileMenuItem(
                      icon: Icons.info_outline,
                      label: 'About',
                      color: const Color(0xFFF3E8FF),
  
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AboutScreen(),
                          ),
                        );
                      },
                    ),

                    _ProfileMenuItem(
                      icon: Icons.storefront_outlined,
                      label: 'My Shop',
                      color: const Color(0xFFE0F2FE),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StoreProfileScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ================= LOGOUT =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),

                child: SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil('/login', (route) => false);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      elevation: 0,

                      padding: const EdgeInsets.symmetric(vertical: 16),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(Icons.logout_rounded, color: Colors.white),

                        SizedBox(width: 10),

                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= MENU ITEM =================

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Icon(icon, color: Colors.black87),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

// ================= FAMILY CARD =================

Widget _familyCard({
  required BuildContext context,
  required String name,
  required String role,
  required Color color,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FamilyMemberDetailScreen(name: name, role: role),
        ),
      );
    },

    child: Container(
      width: 110,
      margin: const EdgeInsets.only(right: 14),

      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            padding: const EdgeInsets.all(3),

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),

            child: const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,

              child: Icon(Icons.person, color: Color(0xFF2ECC71), size: 24),
            ),
          ),

          const SizedBox(height: 10),

          Flexible(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 3),

          Flexible(
            child: Text(
              role,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,

              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ================= ADD MEMBER =================

Widget _addMemberCard() {
  return Container(
    width: 105,

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),

      border: Border.all(color: const Color(0xFF2ECC71), width: 1.5),
    ),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: const [
        CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFF2ECC71),

          child: Icon(Icons.add, color: Colors.white),
        ),

        SizedBox(height: 12),

        Text(
          "Add Member",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}

// ================= STATS =================

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

// ================= DIVIDER =================

class _DividerVertical extends StatelessWidget {
  const _DividerVertical();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 35, color: const Color(0xFFE5E7EB));
  }
}
