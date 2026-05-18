import 'recipe_model.dart';

class SimulationAiModel {
  final String summary;

  final int totalBudget;
  final int dailyBudget;

  final int totalDays;
  final int totalPeople;

  final String nutritionInsight;

  final String healthyLevel;

  final String tips;

  final List<RecipeModel> recipes;

  SimulationAiModel({
    required this.summary,
    required this.totalBudget,
    required this.dailyBudget,
    required this.totalDays,
    required this.totalPeople,
    required this.nutritionInsight,
    required this.healthyLevel,
    required this.tips,
    required this.recipes,
  });

  factory SimulationAiModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SimulationAiModel(
      summary: json['summary'] ?? '',

      totalBudget: json['total_budget'] ?? 0,

      dailyBudget: json['daily_budget'] ?? 0,

      totalDays: json['total_days'] ?? 0,

      totalPeople: json['total_people'] ?? 0,

      nutritionInsight:
          json['nutrition_insight'] ?? '',

      healthyLevel:
          json['healthy_level'] ?? '',

      tips: json['tips'] ?? '',

      recipes:
          (json['recipes'] as List? ?? [])
              .map(
                (e) => RecipeModel.fromJson(e),
              )
              .toList(),
    );
  }
}