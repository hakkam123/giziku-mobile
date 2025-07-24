import 'package:flutter/material.dart';
import 'simulation_step3.dart';

class SimulationStep2 extends StatefulWidget {
  const SimulationStep2({super.key});

  @override
  State<SimulationStep2> createState() => _SimulationStep2State();
}

class _SimulationStep2State extends State<SimulationStep2> {
  String _selectedActivity = '';
  
  final List<Map<String, dynamic>> _activityLevels = [
    {
      'level': 'Sedentary',
      'icon': Icons.weekend_outlined,
      'description': 'Little or no exercise, desk job',
    },
    {
      'level': 'Lightly Active',
      'icon': Icons.directions_walk,
      'description': 'Light exercise 1-3 days/week',
    },
    {
      'level': 'Moderately Active',
      'icon': Icons.directions_run,
      'description': 'Moderate exercise 3-5 days/week',
    },
    {
      'level': 'Very Active',
      'icon': Icons.fitness_center,
      'description': 'Hard exercise 6-7 days/week',
    },
    {
      'level': 'Extra Active',
      'icon': Icons.sports_gymnastics,
      'description': 'Very hard exercise, physical job or training twice a day',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Step 2: Activity Level',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress indicator
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4, // 40% progress
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2ECC71),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Title
                    const Text(
                      'What\'s your activity level?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Your activity level helps determine your daily calorie needs.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Activity level selection
                    ..._activityLevels.map((activity) => _buildActivityOption(
                      level: activity['level'],
                      icon: activity['icon'],
                      description: activity['description'],
                    )),
                  ],
                ),
              ),
            ),
            
            // Bottom button
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedActivity.isNotEmpty 
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SimulationStep3()),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2ECC71),
                    disabledBackgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityOption({
    required String level,
    required IconData icon,
    required String description,
  }) {
    final isSelected = _selectedActivity == level;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedActivity = level;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE7FCF1) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF2ECC71) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2ECC71) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? const Color(0xFF2ECC71) : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: level,
              groupValue: _selectedActivity,
              onChanged: (value) {
                setState(() {
                  _selectedActivity = value!;
                });
              },
              activeColor: const Color(0xFF2ECC71),
            ),
          ],
        ),
      ),
    );
  }
}
