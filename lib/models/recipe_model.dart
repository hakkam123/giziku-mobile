class RecipeModel {
  final String? id;
  final String title;
  final String imageUrl;
  final String category;
  final int price;
  final int nutrition; 
  final String nutritionUnit; 
  final int prepTime; 
  final int cookTime; 
  final int totalTime; 
  final String description;
  final List<RecipeIngredient> ingredients;
  final List<String> instructions;

  RecipeModel({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.nutrition,
    required this.nutritionUnit,
    required this.prepTime,
    required this.cookTime,
    required this.totalTime,
    required this.description,
    required this.ingredients,
    required this.instructions,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
      category: json['category'],
      price: json['price'],
      nutrition: json['nutrition'],
      nutritionUnit: json['nutrition_unit'] ?? "g",
      prepTime: json['prep_time'],
      cookTime: json['cook_time'],
      totalTime: json['total_time'],
      description: json['description'],
      ingredients: (json['ingredients'] as List)
          .map((e) => RecipeIngredient.fromJson(e))
          .toList(),
      instructions: List<String>.from(json['instructions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'category': category,
      'price': price,
      'nutrition': nutrition,
      'nutrition_unit': nutritionUnit,
      'prep_time': prepTime,
      'cook_time': cookTime,
      'total_time': totalTime,
      'description': description,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'instructions': instructions,
    };
  }
}

class RecipeIngredient {
  final String name;
  final String amount;

  RecipeIngredient({
    required this.name,
    required this.amount,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      name: json['name'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
    };
  }
}

// class RecipeModel {
//   final String? id;

//   // Basic Info
//   final String title;
//   final String imageUrl;
//   final String category;
//   final String description;

//   // Pricing
//   final int estimatedPrice;

//   // Portion
//   final int servings;

//   // Time
//   final int prepTime;
//   final int cookTime;
//   final int totalTime;

//   // Nutrition
//   final RecipeNutrition nutrition;

//   // Difficulty
//   final String difficulty;

//   // Ingredients & Steps
//   final List<RecipeIngredient> ingredients;
//   final List<String> instructions;

//   // Extra
//   final List<String> tags;

//   RecipeModel({
//     this.id,
//     required this.title,
//     required this.imageUrl,
//     required this.category,
//     required this.description,
//     required this.estimatedPrice,
//     required this.servings,
//     required this.prepTime,
//     required this.cookTime,
//     required this.totalTime,
//     required this.nutrition,
//     required this.difficulty,
//     required this.ingredients,
//     required this.instructions,
//     required this.tags,
//   });

//   factory RecipeModel.fromJson(Map<String, dynamic> json) {
//     return RecipeModel(
//       id: json['id'],

//       title: json['title'] ?? '',
//       imageUrl: json['image_url'] ?? '',
//       category: json['category'] ?? '',
//       description: json['description'] ?? '',

//       estimatedPrice: json['estimated_price'] ?? 0,

//       servings: json['servings'] ?? 1,

//       prepTime: json['prep_time'] ?? 0,
//       cookTime: json['cook_time'] ?? 0,
//       totalTime: json['total_time'] ?? 0,

//       nutrition: RecipeNutrition.fromJson(
//         json['nutrition'] ?? {},
//       ),

//       difficulty: json['difficulty'] ?? 'Easy',

//       ingredients: (json['ingredients'] as List? ?? [])
//           .map((e) => RecipeIngredient.fromJson(e))
//           .toList(),

//       instructions:
//           List<String>.from(json['instructions'] ?? []),

//       tags: List<String>.from(json['tags'] ?? []),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,

//       'title': title,
//       'image_url': imageUrl,
//       'category': category,
//       'description': description,

//       'estimated_price': estimatedPrice,

//       'servings': servings,

//       'prep_time': prepTime,
//       'cook_time': cookTime,
//       'total_time': totalTime,

//       'nutrition': nutrition.toJson(),

//       'difficulty': difficulty,

//       'ingredients':
//           ingredients.map((e) => e.toJson()).toList(),

//       'instructions': instructions,

//       'tags': tags,
//     };
//   }
// }

// class RecipeIngredient {
//   final String name;
//   final String amount;

//   RecipeIngredient({
//     required this.name,
//     required this.amount,
//   });

//   factory RecipeIngredient.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return RecipeIngredient(
//       name: json['name'] ?? '',
//       amount: json['amount'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'amount': amount,
//     };
//   }
// }

// class RecipeNutrition {
//   final int calories;
//   final int protein;
//   final int carbs;
//   final int fats;

//   final int sugars;
//   final int sodium;
//   final int fiber;

//   final String nutritionPerServing;

//   final VitaminsModel vitamins;

//   final int healthScore;

//   final String healthInsight;
//   final String healthyLevel;

//   RecipeNutrition({
//     required this.calories,
//     required this.protein,
//     required this.carbs,
//     required this.fats,
//     required this.sugars,
//     required this.sodium,
//     required this.fiber,
//     required this.nutritionPerServing,
//     required this.vitamins,
//     required this.healthScore,
//     required this.healthInsight,
//     required this.healthyLevel,
//   });

//   factory RecipeNutrition.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return RecipeNutrition(
//       calories: json['calories'] ?? 0,
//       protein: json['protein'] ?? 0,
//       carbs: json['carbs'] ?? 0,
//       fats: json['fats'] ?? 0,

//       sugars: json['sugars'] ?? 0,
//       sodium: json['sodium'] ?? 0,
//       fiber: json['fiber'] ?? 0,

//       nutritionPerServing:
//           json['nutrition_per_serving'] ?? '',

//       vitamins: VitaminsModel.fromJson(
//         json['vitamins'] ?? {},
//       ),

//       healthScore: json['health_score'] ?? 0,

//       healthInsight:
//           json['health_insight'] ?? '',

//       healthyLevel:
//           json['healthy_level'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'calories': calories,
//       'protein': protein,
//       'carbs': carbs,
//       'fats': fats,

//       'sugars': sugars,
//       'sodium': sodium,
//       'fiber': fiber,

//       'nutrition_per_serving':
//           nutritionPerServing,

//       'vitamins': vitamins.toJson(),

//       'health_score': healthScore,

//       'health_insight': healthInsight,

//       'healthy_level': healthyLevel,
//     };
//   }
// }

// class VitaminsModel {
//   final String vitaminA;
//   final String vitaminC;
//   final String iron;

//   VitaminsModel({
//     required this.vitaminA,
//     required this.vitaminC,
//     required this.iron,
//   });

//   factory VitaminsModel.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return VitaminsModel(
//       vitaminA: json['vitaminA'] ?? '',
//       vitaminC: json['vitaminC'] ?? '',
//       iron: json['iron'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'vitaminA': vitaminA,
//       'vitaminC': vitaminC,
//       'iron': iron,
//     };
//   }
// }