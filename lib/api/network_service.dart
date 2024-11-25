import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:food_spotlight/constant/dummy_data.dart';
import 'package:http/http.dart' as http;

import 'package:food_spotlight/api/prepare_prompt.dart';
import 'package:food_spotlight/constant/api_keys.dart';
import 'package:food_spotlight/models/product_info.dart';
import 'package:food_spotlight/models/search.dart';

class NetworkService {
  String responseText = '';

  Future<String?> generateAIResponse(File imageFile, String prompt) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    // Prepend the required prefix to the base64 image
    String base64Image = 'data:image/jpeg;base64,${base64Encode(imageBytes)}';

    const apiUrl = 'https://api.sambanova.ai/v1/chat/completions';
    const apiKey = sambanovaAPIKey; // Replace with your actual API key

    final requestBody = {
      'model': 'Llama-3.2-90B-Vision-Instruct',
      'messages': [
        {
          'role': 'user',
          'content': [
            {
              'type': 'text',
              'text': '''response must be json object as this {
    "servingSize": "2 oz (56g)", // Serving size as indicated on packaging 
    "date": "2023-11-21T19:36:47.267Z", // Date and time of the search (example format, will vary)
    "ingredients": [
      {
        "name": "Organic Whole Wheat Flour", // Common name of the ingredient
        "scientificName": "Triticum aestivum", // Scientific name for precise identification
        "function": "Main ingredient", // Role of the ingredient in the product
        "source": "USA", // Origin or source of the ingredient
        "healthImplications": "Good source of fiber", // Potential health effects
        "sustainability": "Sustainably farmed", // Information on sustainability of sourcing
        "isOrganic": true, // Whether the ingredient is organic
        "isGMO": false, // Whether the ingredient is genetically modified
        "isFairTrade": false // Whether the ingredient is fair trade certified
      }
    ],
    "nutritionalInfo": {
      "servingSize": "2 oz (56g)", // Serving size for the nutritional information
      "calories": "200", // Calories per serving
      "macronutrients": [ 
        {"name": "Total Fat", "amount": "1g"},
        {"name": "Protein", "amount": "7g"},
        {"name": "Total Carbohydrates", "amount": "42g"}
      ],
      "micronutrients": [
        {"name": "Iron", "amount": "8% DV"} 
      ],
      "dailyValuePercentage": {"Iron": "8%", "Calcium": "2%"}, // % Daily Value for each nutrient
      "addedSugar": "0", // Amount of added sugar per serving
      "naturalSugar": "2", // Amount of naturally occurring sugar per serving
      "sugarAlcohol": "0" // Amount of sugar alcohol per serving
    },
    "tags": ["organic", "whole wheat", "vegan"], // Tags associated with the product
    "categories": ["pasta", "grains"], // Categories the product belongs to
    "labels": ["USDA Organic"], // Certification labels 
    "allergens": ["Wheat"], // Potential allergens present
    "diets": ["Vegetarian", "Vegan"], // Suitable diets for the product
    "healthLabels": ["Good source of fiber"], // Health claims about the product 
    "cautions": [] // Cautions or warnings associated with the product
  } $prompt''',
            },
            {
              'type': 'image_url',
              'image_url': {
                'url': base64Image,
              },
            }
          ],
        },
      ],
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    // print('API Response Status: ${response.statusCode}');
    // print('API Response Body: ${response.body}'); // Debugging line

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // print('Decoded JSON Data: $responseData'); // Debugging line
      if (responseData['choices'] != null &&
          responseData['choices'].isNotEmpty) {
        String answer = responseData['choices'][0]['message']['content'];
        // print('Extracted Answer: $answer'); // Debugging line
        responseText = answer;
        return answer;
      } else {
        throw Exception('No choices found in AI response: ${response.body}');
      }
    } else {
      throw Exception('Failed to generate AI response: ${response.body}');
    }
  }

  Future<ProductInfo> generateProductInfo(File image, String prompt) async {
    try {
      final result = await generateAIResponse(image, prompt);
      // print('AI Response Result: $result'); // Debugging line
      if (result == null) {
        throw Exception(
            'Failed to analyze image and text due to AI generated null response.');
      } else {
        // String jsonResult = result;
        // print('JSON Result to Parse: $jsonResult'); // Debugging line
        // final productInfo = ProductInfo.fromJson(jsonDecode(jsonResult));
        final productInfo =
            ProductInfo.fromJson(jsonDecode(demoProductInfoJsonString));
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

  Future<String> generateAIQueryResponse(
      String contextText, String question) async {
    const apiUrl = 'https://api.sambanova.ai/v1/chat/completions';
    const apiKey = sambanovaAPIKey; // Replace with your actual API key

    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'stream': true,
      'model': 'Meta-Llama-3.1-405B-Instruct',
      'messages': [
        {
          'role': 'system',
          'content': contextText,
        },
        {
          'role': 'user',
          'content': question,
        },
      ],
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to generate response');
    }
  }
}
