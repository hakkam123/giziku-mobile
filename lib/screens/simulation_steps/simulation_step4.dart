import 'package:flutter/material.dart';
import 'simulation_step5.dart';

class SimulationStep4 extends StatefulWidget {
  const SimulationStep4({super.key});

  @override
  State<SimulationStep4> createState() => _SimulationStep4State();
}

class _SimulationStep4State extends State<SimulationStep4> {
  final List<String> _selectedRestrictions = [];
  
  final List<Map<String, dynamic>> _dietaryRestrictions = [
    {
      'name': 'Dairy-Free',
      'icon': Icons.no_drinks,
    },
    {
      'name': 'Gluten-Free',
      'icon': Icons.bakery_dining,
    },
    {
      'name': 'Vegetarian',
      'icon': Icons.eco,
    },
    {
      'name': 'Vegan',
      'icon': Icons.grass,
    },
    {
      'name': 'Nut-Free',
      'icon': Icons.block,
    },
    {
      'name': 'Low-Carb',
      'icon': Icons.grain,
    },
    {
      'name': 'Low-Fat',
      'icon': Icons.no_food,
    },
    {
      'name': 'Low-Sodium',
      'icon': Icons.do_not_disturb_on,
    },
    {
      'name': 'Keto',
      'icon': Icons.food_bank,
    },
    {
      'name': 'Pescatarian',
      'icon': Icons.set_meal,
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
          'Step 4: Dietary Restrictions',
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
                            width: MediaQuery.of(context).size.width * 0.8, // 80% progress
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
                      'Any dietary restrictions?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Select any dietary restrictions or preferences. This helps us customize your meal suggestions.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Dietary restrictions grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _dietaryRestrictions.length,
                      itemBuilder: (context, index) {
                        final restriction = _dietaryRestrictions[index];
                        return _buildRestrictionOption(
                          name: restriction['name'],
                          icon: restriction['icon'],
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Note
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.amber.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.amber.shade800,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Select all that apply. If none, simply continue to the next step.',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: Colors.amber.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SimulationStep5()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2ECC71),
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

  Widget _buildRestrictionOption({
    required String name,
    required IconData icon,
  }) {
    final isSelected = _selectedRestrictions.contains(name);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedRestrictions.remove(name);
          } else {
            _selectedRestrictions.add(name);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2ECC71) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? const Color(0xFF2ECC71) : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
