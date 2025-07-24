import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0; // 0 untuk Home, 1 untuk Simulation, dst
  int _selectedDayIndex = 3; // Defaultnya hari ke-4 (Rabu)
  bool _isWeekSelected = true; // Default tampilan grafik adalah mingguan
  
  final List<String> _daysShort = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final List<int> _dates = [1, 2, 3, 4, 5, 6, 7];
  
  // Data untuk grafik kalori mingguan
  final List<double> _weeklyCalories = [1000, 800, 900, 100, 300, 850, 650];
  
  @override
  Widget build(BuildContext context) {
    // Mendapatkan tanggal hari ini
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(now);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan profil dan notifikasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Avatar dan greeting
                    Row(
                      children: [
                        Container(
                          width: 45, // Kurangi dari 50 ke 45
                          height: 45, // Kurangi dari 50 ke 45
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC857),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 25, // Kurangi dari 30 ke 25
                            ),
                          ),
                        ),
                        const SizedBox(width: 10), // Kurangi dari 12 ke 10
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello, Jenny!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Notification icon
                    Container(
                      width: 38, 
                      height: 38, 
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7FCF1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Color(0xFF2ECC71),
                          size: 22, 
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 15), 
              
              // Target Calories Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Target Calories',
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              
              const SizedBox(height: 8), 
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 190, 
                  decoration: BoxDecoration(
                    color: const Color(0xFF2ECC71),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 15,
                        child: ClipPath(
                          clipper: TriangleClipper(),
                          child: Container(
                            width: 18, 
                            height: 9, 
                            color: Colors.white,
                          ),
                        ),
                      ),
                      
                      CircularPercentIndicator(
                        radius: 75.0, 
                        lineWidth: 22.0, 
                        animation: true,
                        percent: 0.75,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.white,
                        backgroundColor: const Color(0xFF27AE60).withOpacity(0.3),
                        center: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '1280',
                              style: TextStyle(
                                fontSize: 32, 
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              'kcal',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 15), 
              
              // Nutrition Intake Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Nutrition Intake',
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              
              const SizedBox(height: 8), 
              
              // Nutrition Intake Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Carbs
                      _buildNutritionItem('88', '/120', 'Carbs', 0.73, Colors.white),
                      
                      // Protein
                      _buildNutritionItem('24', '/70', 'Protein', 0.34, Colors.white),
                      
                      // Vitamin
                      _buildNutritionItem('32', '/52', 'Vitamin', 0.62, const Color(0xFF2ECC71)),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 15), 
              
              // Date Selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 65, 
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      bool isSelected = index == _selectedDayIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDayIndex = index;
                          });
                        },
                        child: Container(
                          width: 42,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF2ECC71) : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFF2ECC71),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _daysShort[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(height: 4), 
                              Text(
                                _dates[index].toString(),
                                style: TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 15), 
              
              // Overview Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Overview Card with Graph
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Week/Month Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Week Button
                          _buildToggleButton('Week', _isWeekSelected, () {
                            setState(() {
                              _isWeekSelected = true;
                            });
                          }),
                          
                          // Month Button
                          _buildToggleButton('Month', !_isWeekSelected, () {
                            setState(() {
                              _isWeekSelected = false;
                            });
                          }),
                        ],
                      ),
                      
                      const SizedBox(height: 15), 
                      
                      // Bar Chart
                      SizedBox(
                        height: 120,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(7, (index) {
                              double maxHeight = 90;
                              double maxValue = _weeklyCalories.reduce((a, b) => a > b ? a : b);
                              double normalizedHeight = (_weeklyCalories[index] / maxValue) * maxHeight;
                              
                              return Container(
                                width: 40,
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (normalizedHeight > 40)
                                      Text(
                                        _weeklyCalories[index].toInt().toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 500),
                                      width: 20,
                                      height: normalizedHeight,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2ECC71),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _daysShort[index][0],
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Calories per day text
                      const Text(
                        'Calories per day',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 15), 
              
              // Water Intake Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Water Intake',
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Water Intake Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Water consumption status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '2 of 5 glasses consumed',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '2.0ᵐᵃ / 5ᵐᵃ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300,
                                ),
                              ),
                            ],
                          ),
                          
                          // Water icon
                          Icon(
                            Icons.local_drink,
                            size: 28,
                            color: Colors.blue.shade300,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 15), 
                      
                      // Water glasses
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(5, (index) {
                            bool isFilled = index < 2; 
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.water_drop,
                                    size: 28, 
                                    color: isFilled ? Colors.blue.shade300 : Colors.blue.shade100,
                                  ),
                                  const SizedBox(height: 4), 
                                  Text(
                                    '500ᵐᵃ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      
      bottomNavigationBar: Container(
        height: 60, 
        padding: const EdgeInsets.symmetric(vertical: 8), 
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.pie_chart, 'Simulation', 1),
            
            // Centered circular button
            Container(
              width: 45, 
              height: 45, 
              decoration: BoxDecoration(
                color: const Color(0xFF2ECC71),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2ECC71).withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.restaurant_menu,
                color: Colors.white,
                size: 22, 
              ),
            ),
            
            _buildNavItem(Icons.menu_book, 'Recipe', 3),
            _buildNavItem(Icons.person_outline, 'Profile', 4),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
        
        if (index == 1) {
          Navigator.pushNamed(context, '/simulation');
        } else if (index == 4) {
          Navigator.pushNamed(context, '/profile');
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF2ECC71) : Colors.grey,
            size: 22, 
          ),
          const SizedBox(height: 2), 
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Poppins',
              color: isSelected ? const Color(0xFF2ECC71) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildToggleButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), 
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF2ECC71) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  
  Widget _buildNutritionItem(String value, String total, String label, double percent, Color progressColor) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              total,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4), // Kurangi dari 5 ke 4
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 6), // Kurangi dari 8 ke 6
        LinearPercentIndicator(
          width: 75.0, // Kurangi dari 80.0 ke 75.0
          lineHeight: 4.0,
          percent: percent,
          backgroundColor: Colors.grey[700],
          progressColor: progressColor,
          padding: EdgeInsets.zero,
          barRadius: const Radius.circular(10),
        ),
      ],
    );
  }
}

// Custom clipper untuk membuat bentuk segitiga
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}