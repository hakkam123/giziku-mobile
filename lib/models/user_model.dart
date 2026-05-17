enum AuthProvider { email, google }

class UserModel {
  // ================= AUTH =================
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? phoneNumber;

  // ================= BASIC INFORMATION =================
  final String? gender;
  final String? dateOfBirth;

  // ================= BODY ANALYSIS =================
  final double? height;
  final double? weight;

  final String? activityLevel;
  final String? exerciseLevel;

  // ================= NUTRITION PREFERENCES =================
  final String? foodType;
  final String? favoriteFoods;
  final String? dislikedFoods;
  final String? allergies;

  // ================= HEALTH =================
  final String? chronicDisease;

  // ================= EATING HABIT =================
  final String? eatingPattern;

  // ================= FITNESS TARGET =================
  final String? bodyGoal;

  // ================= SYSTEM CALCULATED =================
  final int? age;

  final double? bmi;
  final String? bmiCategory;

  final double? idealWeight;

  final int? dailyCalories;

  final int? proteinNeed;
  final int? carbNeed;
  final int? fatNeed;

  final int? sugarLimit;
  final int? sodiumLimit;

  // ================= SYSTEM =================
  final DateTime createdAt;
  final DateTime updatedAt;

  final AuthProvider authProvider;

  // ================= TOKEN =================
  final String? token;
  final String? refreshToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,

    this.photoUrl,
    this.phoneNumber,

    this.gender,
    this.dateOfBirth,

    this.height,
    this.weight,

    this.activityLevel,
    this.exerciseLevel,

    this.foodType,
    this.favoriteFoods,
    this.dislikedFoods,
    this.allergies,

    this.chronicDisease,

    this.eatingPattern,

    this.bodyGoal,

    this.age,

    this.bmi,
    this.bmiCategory,

    this.idealWeight,

    this.dailyCalories,

    this.proteinNeed,
    this.carbNeed,
    this.fatNeed,

    this.sugarLimit,
    this.sodiumLimit,

    required this.createdAt,
    required this.updatedAt,

    required this.authProvider,

    this.token,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // ================= AUTH =================
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',

      photoUrl: json['photo_url'],
      phoneNumber: json['phone_number'],

      // ================= BASIC =================
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],

      // ================= BODY =================
      height: json['height'] != null
          ? (json['height'] as num).toDouble()
          : null,

      weight: json['weight'] != null
          ? (json['weight'] as num).toDouble()
          : null,

      activityLevel: json['activity_level'],
      exerciseLevel: json['exercise_level'],

      // ================= FOOD =================
      foodType: json['food_type'],
      favoriteFoods: json['favorite_foods'],
      dislikedFoods: json['disliked_foods'],
      allergies: json['allergies'],

      // ================= HEALTH =================
      chronicDisease: json['chronic_disease'],

      // ================= HABIT =================
      eatingPattern: json['eating_pattern'],

      // ================= GOAL =================
      bodyGoal: json['body_goal'],

      // ================= SYSTEM =================
      age: json['age'],

      bmi: json['bmi'] != null
          ? (json['bmi'] as num).toDouble()
          : null,

      bmiCategory: json['bmi_category'],

      idealWeight: json['ideal_weight'] != null
          ? (json['ideal_weight'] as num).toDouble()
          : null,

      dailyCalories: json['daily_calories'],

      proteinNeed: json['protein_need'],
      carbNeed: json['carb_need'],
      fatNeed: json['fat_need'],

      sugarLimit: json['sugar_limit'],
      sodiumLimit: json['sodium_limit'],

      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),

      authProvider: _parseAuthProvider(
        json['auth_provider'] ?? 'email',
      ),

      token: json['token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // ================= AUTH =================
      'id': id,
      'name': name,
      'email': email,

      'photo_url': photoUrl,
      'phone_number': phoneNumber,

      // ================= BASIC =================
      'gender': gender,
      'date_of_birth': dateOfBirth,

      // ================= BODY =================
      'height': height,
      'weight': weight,

      'activity_level': activityLevel,
      'exercise_level': exerciseLevel,

      // ================= FOOD =================
      'food_type': foodType,
      'favorite_foods': favoriteFoods,
      'disliked_foods': dislikedFoods,
      'allergies': allergies,

      // ================= HEALTH =================
      'chronic_disease': chronicDisease,

      // ================= HABIT =================
      'eating_pattern': eatingPattern,

      // ================= GOAL =================
      'body_goal': bodyGoal,

      // ================= SYSTEM =================
      'age': age,

      'bmi': bmi,
      'bmi_category': bmiCategory,

      'ideal_weight': idealWeight,

      'daily_calories': dailyCalories,

      'protein_need': proteinNeed,
      'carb_need': carbNeed,
      'fat_need': fatNeed,

      'sugar_limit': sugarLimit,
      'sodium_limit': sodiumLimit,

      // ================= SYSTEM =================
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),

      'auth_provider':
          authProvider.toString().split('.').last,

      // ================= TOKEN =================
      'token': token,
      'refresh_token': refreshToken,
    };
  }

  static AuthProvider _parseAuthProvider(
    String provider,
  ) {
    switch (provider.toLowerCase()) {
      case 'google':
        return AuthProvider.google;

      case 'email':
      default:
        return AuthProvider.email;
    }
  }
}