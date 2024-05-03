import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:food_spotlight/api/prepare_prompt.dart';
import 'package:food_spotlight/constant/api_keys.dart';
import 'package:food_spotlight/models/product_info.dart';
import 'package:food_spotlight/models/search.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class NetworkService {
  final model = GenerativeModel(
    model: 'gemini-1.0-pro-vision-latest',
    apiKey: geminiAPIKey,
    generationConfig: GenerationConfig(
      maxOutputTokens: 8192,
      topP: 0.98,
      topK: 0,
      temperature: 1,
    ),
  );
  String responseText = '';

  Future<String?> generateAIResponse(File imageFile, String prompt) async {
    Uint8List image = await imageFile.readAsBytes();

    final response = await model.generateContent([
      Content.multi([TextPart(prompt), DataPart('image/jpeg', image)])
    ]);
    responseText = response.text ?? '';
    return response.text;
  }

  Future<ProductInfo> generateProductInfo(File image, String prompt) async {
    try {
      final result = await generateAIResponse(image, prompt);
      if (result == null) {
        throw Exception(
            'Failed to analyze image and text due to AI generated null response.');
      } else {
        String jsonResult =
            result.replaceAll('```json', '').replaceAll('```', '');
        final productInfo = ProductInfo.fromJson(jsonDecode(jsonResult));
        return productInfo;
      }
    } catch (e) {
      throw Exception('Failed to analyze image and text: $e');
    }
  }

  Future<Search> analyzeImageAndText(File image, String foodName) async {
    final productInfo = await generateProductInfo(
      image,
      preparePrompt(foodName),
    );
    return Search(
      productName: foodName,
      productImage: image,
      productInfo: productInfo,
      responseText: responseText,
    );
  }
}
