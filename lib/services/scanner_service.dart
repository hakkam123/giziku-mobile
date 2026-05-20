import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/food_scan_model.dart';

class ScannerService {
  final dio = Dio();

  final model = GenerativeModel(
    model: 'models/gemini-3.1-flash-lite',
    apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
    generationConfig: GenerationConfig(temperature: 0.2),
  );

  Future<FoodScanModel> scanFood(File image) async {
    final compressed = await FlutterImageCompress.compressWithFile(
      image.absolute.path,
      quality: 40,
      minWidth: 512,
      minHeight: 512,
    );

    final bytes = compressed!;

    /// model

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path, filename: 'scan.jpg'),
      });

      final response = await dio.post(
        'https://giziku-backend-production.up.railway.app/predict',
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data;

      print(data);

      final double confidence = (data['confidence'] ?? 0).toDouble();

      print("CONFIDENCE: $confidence");

      /// kalau confidence tinggi
      if (confidence >= 75) {
        final detectedFood = data['foodName'];

        return await analyzeWithGemini(bytes, detectedFood);
      }
    } catch (e) {
      print(e);
    }

    /// fallback full Gemini
    return await analyzeWithGemini(bytes, null);
  }

  /// =========================
  /// GEMINI ANALYZER
  /// =========================

  Future<FoodScanModel> analyzeWithGemini(
    Uint8List bytes,
    String? detectedFood,
  ) async {
    final prompt =
        '''
Kamu adalah AI nutritionist profesional.

Analisis makanan dari gambar.

ATURAN:
- Gunakan Bahasa Indonesia.
- Return JSON valid saja.
- Jangan gunakan markdown.
- Jangan tambahkan penjelasan.

${detectedFood != null ? '''
Makanan telah dikenali oleh AI internal sebagai:
"$detectedFood"

Gunakan nama makanan tersebut sebagai referensi utama.
''' : ''}

FORMAT:

{
  "foodName": "",
  "isEdible": true,
  "estimatedServing": "",
  "calories": 0,
  "protein": 0,
  "carbs": 0,
  "fats": 0,
  "sugars": 0,
  "sodium": 0,
  "fiber": 0,

  "nutritionPerServing": "",

  "vitamins": {
    "vitaminA": "",
    "vitaminC": "",
    "iron": ""
  },

  "healthScore": 0,
  "healthInsight": "",
  "healthyLevel": ""
}

KETENTUAN:
- Estimasi nutrisi harus realistis.
- Jika gambar blur, tetap berikan estimasi terbaik.
- Health score dari 1-10.
''';

    final response = await model.generateContent([
      Content.multi([TextPart(prompt), DataPart('image/jpeg', bytes)]),
    ]);

    String text = response.text ?? '';

    text = text.replaceAll('```json', '');
    text = text.replaceAll('```', '');
    text = text.trim();

    final jsonMap = jsonDecode(text);

    jsonMap['fromPredict'] = detectedFood != null;

    return FoodScanModel.fromJson(jsonMap);
  }
}
