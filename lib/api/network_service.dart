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
              'text': prompt,
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

  Stream<String> generateAIQueryResponse(String contextText, String question) async* {
    const apiUrl = 'https://api.sambanova.ai/v1/chat/completions';
    const apiKey = sambanovaAPIKey; // Replace with your actual API key

    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'stream': true,
      'model': 'Meta-Llama-3.1-8B-Instruct',
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

    final request = http.Request('POST', Uri.parse(apiUrl));
    request.headers.addAll(headers);
    request.body = body;

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to generate AI response: ${response.statusCode}');
    }

    final stream = response.stream.transform(utf8.decoder);

    await for (var value in stream) {
      final lines = value.split('\n');
      for (var line in lines) {
        line = line.trim();
        if (line.startsWith('data: ')) {
          final dataString = line.substring(6).trim();
          if (dataString == '[DONE]') {
            return;
          }
          try {
            final jsonData = jsonDecode(dataString);
            final choices = jsonData['choices'];
            if (choices != null && choices.isNotEmpty) {
              final delta = choices[0]['delta'];
              final content = delta['content'];
              if (content != null && content.isNotEmpty) {
                yield content;
              }
            }
          } catch (e) {
            // Handle parsing errors
            print('Parsing Error: $e');
          }
        }
      }
    }
  }
}
