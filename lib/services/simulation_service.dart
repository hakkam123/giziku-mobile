import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../models/simulation_ai_model.dart';

class SimulationService {
  final model = GenerativeModel(
    model: 'models/gemini-2.5-flash',
    apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
    generationConfig: GenerationConfig(
      temperature: 0.4,
    ),
  );

  Future<SimulationAiModel> generateMealPlan({
    required int budget,
    required int days,
    required int people,
  }) async {
    final prompt = '''
Kamu adalah AI nutrition planner profesional.

Buatkan meal plan hemat dan sehat.

DATA USER:
- Budget: Rp$budget
- Durasi: $days hari
- Jumlah orang: $people orang

ATURAN:
- Gunakan Bahasa Indonesia
- Fokus makanan Indonesia
- Budget harus realistis
- Makanan sederhana dan sehat
- Return HANYA JSON valid
- Jangan gunakan markdown
- Jangan tambahkan teks selain JSON

FORMAT JSON:

{
  "summary": "",
  "dailyBudget": 0,
  "nutritionInsight": "",
  "tips": "",

  "mealPlans": [
    {
      "title": "",
      "description": "",
      "estimatedCalories": 0,
      "estimatedPrice": 0
    }
  ]
}
''';

    final response = await model.generateContent([
      Content.text(prompt),
    ]);

    String text = response.text ?? '';

    text = text.replaceAll('```json', '');
    text = text.replaceAll('```', '');
    text = text.trim();

    final jsonMap = jsonDecode(text);

    return SimulationAiModel.fromJson(
      jsonMap,
    );
  }
}