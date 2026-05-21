import 'package:flutter/material.dart';

class FamilyMemberDetailScreen extends StatelessWidget {
  final String name;
  final String role;

  const FamilyMemberDetailScreen({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),

        slivers: [
          // ================= HEADER =================
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: const Color(0xFF2ECC71),
            elevation: 0,

            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF2ECC71)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2AD882), Color(0xFF2ECC71)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 52,
                            color: Color(0xFF2ECC71),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        role,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          runSpacing: 12,

                          children: const [
                            _MiniStat(title: 'BMI', value: '22.1'),

                            _MiniStat(title: 'Calories', value: '2100'),

                            _MiniStat(title: 'Status', value: 'Healthy'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ================= CONTENT =================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const _SectionTitle(title: 'Basic Information'),

                  const SizedBox(height: 18),

                  _infoCard(
                    children: const [
                      _InfoTile(
                        icon: Icons.person_outline,
                        title: 'Full Name',
                        value: 'Jenny Perdana',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.cake_outlined,
                        title: 'Age',
                        value: '29 Years Old',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.female_outlined,
                        title: 'Gender',
                        value: 'Female',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.height,
                        title: 'Height',
                        value: '165 cm',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.monitor_weight_outlined,
                        title: 'Weight',
                        value: '60 kg',
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const _SectionTitle(title: 'Nutrition & Body Analysis'),

                  const SizedBox(height: 18),

                  _infoCard(
                    children: const [
                      _InfoTile(
                        icon: Icons.calculate_outlined,
                        title: 'Body Mass Index (BMI)',
                        value: '22.1 (Normal)',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.local_fire_department_outlined,
                        title: 'Daily Calorie Needs',
                        value: '2100 kcal/day',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.restaurant_menu_outlined,
                        title: 'Nutrition Target',
                        value: 'Balanced Nutrition',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.sports_gymnastics_outlined,
                        title: 'Physical Activity',
                        value: 'Moderately Active',
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const _SectionTitle(title: 'Health Conditions'),

                  const SizedBox(height: 18),

                  _infoCard(
                    children: const [
                      _InfoTile(
                        icon: Icons.coronavirus_outlined,
                        title: 'Chronic Disease',
                        value: 'None',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.warning_amber_outlined,
                        title: 'Allergies',
                        value: 'Seafood Allergy',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.medication_outlined,
                        title: 'Current Medication',
                        value: 'Vitamin Supplement',
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const _SectionTitle(title: 'Physiological & Hormonal Status'),

                  const SizedBox(height: 18),

                  _infoCard(
                    children: const [
                      _InfoTile(
                        icon: Icons.favorite_outline,
                        title: 'Hormonal Status',
                        value: 'Normal',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.pregnant_woman_outlined,
                        title: 'Pregnancy Status',
                        value: 'Not Pregnant',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.water_drop_outlined,
                        title: 'Menstrual Cycle',
                        value: 'Regular',
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const _SectionTitle(title: 'Lifestyle & Eating Behaviour'),

                  const SizedBox(height: 18),

                  _infoCard(
                    children: const [
                      _InfoTile(
                        icon: Icons.fastfood_outlined,
                        title: 'Eating Pattern',
                        value: '3 Meals + 2 Snacks',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.psychology_outlined,
                        title: 'Nutrition Knowledge',
                        value: 'Intermediate',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.self_improvement_outlined,
                        title: 'Body Image Goal',
                        value: 'Maintain Healthy Weight',
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const _SectionTitle(title: 'Genetics & Metabolism'),

                  const SizedBox(height: 18),

                  _infoCard(
                    children: const [
                      _InfoTile(
                        icon: Icons.science_outlined,
                        title: 'Metabolism Type',
                        value: 'Normal Metabolism',
                      ),

                      _InfoDivider(),

                      _InfoTile(
                        icon: Icons.biotech_outlined,
                        title: 'Genetic Risk',
                        value: 'Low Diabetes Risk',
                      ),
                    ],
                  ),

                  const SizedBox(height: 34),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2ECC71),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 18),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),

                      child: const Text(
                        'Edit Family Member',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(children: children),
    );
  }
}

// ================= SECTION TITLE =================

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// ================= MINI STAT =================

class _MiniStat extends StatelessWidget {
  final String title;
  final String value;

  const _MiniStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 90),

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: 'Poppins',
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= INFO TILE =================

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            color: const Color(0xFFE8FFF1),
            borderRadius: BorderRadius.circular(14),
          ),

          child: Icon(icon, color: const Color(0xFF2ECC71), size: 22),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ================= DIVIDER =================

class _InfoDivider extends StatelessWidget {
  const _InfoDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Divider(height: 1, color: Color(0xFFF0F0F0)),
    );
  }
}

// ================= OPTIONAL HEALTH TAG =================

class _HealthTag extends StatelessWidget {
  final String text;
  final Color color;

  const _HealthTag({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
