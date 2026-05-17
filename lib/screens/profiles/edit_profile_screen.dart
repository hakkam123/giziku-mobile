import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final _formKey = GlobalKey<FormState>();

  // ================= CONTROLLERS =================
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final ageController = TextEditingController();

  final genderController = TextEditingController();

  final heightController = TextEditingController();

  final weightController = TextEditingController();

  final bmiController = TextEditingController();

  final bmiStatusController = TextEditingController();

  final idealWeightController = TextEditingController();

  final caloriesController = TextEditingController();

  final activityController = TextEditingController();

  final exerciseController = TextEditingController();

  final bodyGoalController = TextEditingController();

  final foodTypeController = TextEditingController();

  final favoriteFoodsController = TextEditingController();

  final dislikedFoodsController = TextEditingController();

  final allergiesController = TextEditingController();

  final healthController = TextEditingController();

  final eatingController = TextEditingController();

  final birthDateController = TextEditingController();

  bool isLoading = true;

  // ================= INIT =================

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // ================= LOAD DATA =================

  Future<void> loadData() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final data = doc.data();

    if (data != null) {
      nameController.text = data['name'] ?? '';

      emailController.text = data['email'] ?? '';

      ageController.text = data['age']?.toString() ?? '';

      genderController.text = data['gender'] ?? '';

      heightController.text = data['height']?.toString() ?? '';

      weightController.text = data['weight']?.toString() ?? '';

      bmiController.text = data['bmi']?.toString() ?? '';

      bmiStatusController.text = data['bmi_status'] ?? '';

      idealWeightController.text = data['ideal_weight']?.toString() ?? '';

      caloriesController.text = data['target_calories']?.toString() ?? '';

      activityController.text = data['activity_level'] ?? '';

      exerciseController.text = data['exercise_level'] ?? '';

      bodyGoalController.text = data['body_goal'] ?? '';

      foodTypeController.text = data['food_type'] ?? '';

      favoriteFoodsController.text = data['favorite_foods'] ?? '';

      dislikedFoodsController.text = data['disliked_foods'] ?? '';

      allergiesController.text = data['allergies'] ?? '';

      healthController.text = data['health_condition'] ?? '';

      eatingController.text = data['eating_pattern'] ?? '';

      birthDateController.text = data['date_of_birth'] ?? '';
    }

    setState(() {
      isLoading = false;
    });
  }

  // ================= BMI CALCULATION =================

  void calculateBMI() {
    final height = double.tryParse(heightController.text);

    final weight = double.tryParse(weightController.text);

    if (height == null || weight == null || height == 0) {
      return;
    }

    final heightMeter = height / 100;

    final bmi = weight / (heightMeter * heightMeter);

    bmiController.text = bmi.toStringAsFixed(1);

    // STATUS BMI

    if (bmi < 18.5) {
      bmiStatusController.text = 'Kurus';
    } else if (bmi < 25) {
      bmiStatusController.text = 'Normal';
    } else if (bmi < 30) {
      bmiStatusController.text = 'Gemuk';
    } else {
      bmiStatusController.text = 'Obesitas';
    }

    // BERAT IDEAL

    double idealWeight;

    if (genderController.text == 'Pria') {
      idealWeight = (height - 100) - ((height - 100) * 0.1);
    } else {
      idealWeight = (height - 100) - ((height - 100) * 0.15);
    }

    idealWeightController.text = idealWeight.toStringAsFixed(1);

    // KALORI

    final calories = (weight * 30).toInt();

    caloriesController.text = calories.toString();
  }

  void calculateAge(DateTime birthDate) {
    final today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    ageController.text = age.toString();
  }
  // ================= SAVE =================

  Future<void> saveProfile() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': nameController.text,

      'email': emailController.text,
      'age': int.tryParse(ageController.text),

      'gender': genderController.text,

      'height': double.tryParse(heightController.text),

      'weight': double.tryParse(weightController.text),

      'bmi': bmiController.text,

      'bmi_status': bmiStatusController.text,

      'ideal_weight': double.tryParse(idealWeightController.text),

      'target_calories': int.tryParse(caloriesController.text),

      'activity_level': activityController.text,

      'exercise_level': exerciseController.text,

      'body_goal': bodyGoalController.text,

      'food_type': foodTypeController.text,

      'favorite_foods': favoriteFoodsController.text,

      'disliked_foods': dislikedFoodsController.text,

      'allergies': allergiesController.text,

      'health_condition': healthController.text,

      'eating_pattern': eatingController.text,

      'date_of_birth': birthDateController.text,

      'updated_at': Timestamp.now(),
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profil berhasil diperbarui')));

    Navigator.pop(context);
  }

  // ================= FIELD =================

  Widget buildField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    int maxLines = 1,
    VoidCallback? onTap,
    Widget? suffixIcon,
    Function(String)? onChanged,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: TextFormField(
        controller: controller,

        keyboardType: keyboardType,

        readOnly: readOnly,

        maxLines: maxLines,

        onTap: onTap,

        onChanged: onChanged,

        style: const TextStyle(fontFamily: 'Poppins'),

        decoration: InputDecoration(
          labelText: label,

          hintText: hint,

          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey.shade500,
          ),

          suffixIcon: suffixIcon,

          filled: true,

          fillColor: readOnly ? Colors.grey.shade100 : const Color(0xFFF8FAFC),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: const BorderSide(color: Color(0xFF2ECC71), width: 2),
          ),
        ),
      ),
    );
  }

  // ================= DROPDOWN =================

  Widget buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: DropdownButtonFormField<String>(
        value: value.isEmpty ? null : value,

        items: items.map((item) {
          return DropdownMenuItem(
            value: item,

            child: Text(item, style: const TextStyle(fontFamily: 'Poppins')),
          );
        }).toList(),

        onChanged: onChanged,

        decoration: InputDecoration(
          labelText: label,

          filled: true,

          fillColor: const Color(0xFFF8FAFC),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: const BorderSide(color: Color(0xFF2ECC71), width: 2),
          ),
        ),
      ),
    );
  }

  // ================= SECTION =================

  Widget buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        Container(
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
        ),

        const SizedBox(height: 28),
      ],
    );
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        elevation: 0,

        backgroundColor: const Color(0xFF2ECC71),

        title: const Text(
          'Edit Profil',

          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              // ================= DASAR =================
              buildSection('Informasi Dasar', [
                buildField(
                  label: 'Nama Lengkap',
                  controller: nameController,
                  hint: 'Contoh: Zolla Perdana',
                ),

                buildField(
                  label: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Contoh: zolla@gmail.com',
                ),

                buildField(
                  label: 'Tanggal Lahir',

                  controller: birthDateController,

                  readOnly: true,

                  suffixIcon: const Icon(Icons.calendar_month),

                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,

                      initialDate: DateTime(2000),

                      firstDate: DateTime(1950),

                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      birthDateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

                      calculateAge(pickedDate);

                      setState(() {});
                    }
                  },
                ),

                buildField(
                  label: 'Umur',

                  controller: ageController,

                  readOnly: true,

                  keyboardType: TextInputType.number,
                ),

                buildDropdown(
                  label: 'Jenis Kelamin',

                  value: genderController.text,

                  items: const ['Pria', 'Wanita'],

                  onChanged: (value) {
                    genderController.text = value ?? '';

                    calculateBMI();

                    setState(() {});
                  },
                ),

                buildField(
                  label: 'Tinggi Badan (cm)',

                  controller: heightController,

                  keyboardType: TextInputType.number,

                  hint: 'Contoh: 170',

                  onChanged: (_) {
                    calculateBMI();
                  },
                ),

                buildField(
                  label: 'Berat Badan (kg)',

                  controller: weightController,

                  keyboardType: TextInputType.number,

                  hint: 'Contoh: 65',

                  onChanged: (_) {
                    calculateBMI();
                  },
                ),
              ]),

              // ================= ANALISIS =================
              buildSection('Analisis Tubuh', [
                buildField(
                  label: 'BMI',

                  controller: bmiController,

                  readOnly: true,
                ),

                buildField(
                  label: 'Status BMI',

                  controller: bmiStatusController,

                  readOnly: true,
                ),

                buildField(
                  label: 'Berat Ideal',

                  controller: idealWeightController,

                  readOnly: true,
                ),

                buildField(
                  label: 'Kebutuhan Kalori',

                  controller: caloriesController,

                  readOnly: true,
                ),

                buildDropdown(
                  label: 'Activity Level',

                  value: activityController.text,

                  items: const ['Rendah', 'Sedang', 'Tinggi'],

                  onChanged: (value) {
                    setState(() {
                      activityController.text = value ?? '';
                    });
                  },
                ),

                buildDropdown(
                  label: 'Exercise Level',

                  value: exerciseController.text,

                  items: const [
                    'Jarang',
                    '1-2x/Minggu',
                    '3-5x/Minggu',
                    'Setiap Hari',
                  ],

                  onChanged: (value) {
                    setState(() {
                      exerciseController.text = value ?? '';
                    });
                  },
                ),

                buildDropdown(
                  label: 'Target Tubuh',

                  value: bodyGoalController.text,

                  items: const [
                    'Menurunkan Berat Badan',
                    'Menambah Massa Otot',
                    'Menjaga Berat Badan',
                  ],

                  onChanged: (value) {
                    setState(() {
                      bodyGoalController.text = value ?? '';
                    });
                  },
                ),
              ]),

              // ================= NUTRISI =================
              buildSection('Preferensi Nutrisi', [
                buildField(
                  label: 'Tipe Makanan',

                  controller: foodTypeController,

                  hint: 'Contoh: Vegetarian, Vegan, Halal',
                ),

                buildField(
                  label: 'Makanan Favorit',

                  controller: favoriteFoodsController,

                  maxLines: 2,

                  hint: 'Contoh: Ayam, Nasi Goreng, Salmon',
                ),

                buildField(
                  label: 'Makanan Tidak Disukai',

                  controller: dislikedFoodsController,

                  maxLines: 2,

                  hint: 'Contoh: Brokoli, Susu, Durian',
                ),

                buildField(
                  label: 'Alergi',

                  controller: allergiesController,

                  maxLines: 2,

                  hint: 'Contoh: Seafood, Kacang, Telur',
                ),
              ]),

              // ================= KESEHATAN =================
              buildSection('Kondisi Kesehatan', [
                buildField(
                  label: 'Riwayat Penyakit',

                  controller: healthController,

                  maxLines: 3,

                  hint: 'Contoh: Diabetes, Hipertensi',
                ),

                buildField(
                  label: 'Pola Makan',

                  controller: eatingController,

                  maxLines: 2,

                  hint: 'Contoh: 3x sehari, Intermittent Fasting',
                ),
              ]),

              const SizedBox(height: 10),

              // ================= BUTTON =================
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: saveProfile,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2ECC71),

                    elevation: 0,

                    padding: const EdgeInsets.symmetric(vertical: 20),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),

                  child: const Text(
                    'Simpan Profil',

                    style: TextStyle(
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
    );
  }
}
