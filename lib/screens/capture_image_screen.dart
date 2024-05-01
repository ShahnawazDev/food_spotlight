import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_spotlight/models/ingredient.dart';
import 'package:food_spotlight/models/nutritional_info.dart';
import 'package:food_spotlight/models/product_info.dart';
import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/providers/recent_searches_provider.dart';
import 'package:food_spotlight/screens/details_screen.dart';
import 'package:image_picker/image_picker.dart';
// ... import your AI interaction logic, models, and providers

class CaptureImageScreen extends ConsumerStatefulWidget {
  const CaptureImageScreen({super.key});

  @override
  ConsumerState<CaptureImageScreen> createState() => _CaptureImageScreenState();
}

class _CaptureImageScreenState extends ConsumerState<CaptureImageScreen> {
  File? _image;
  final _foodNameController = TextEditingController();

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_image == null) return;

    // Implement your loading screen logic here (e.g., using a dialog)
    // ...

    // Implement your AI interaction logic here
    // ... assuming it returns a RecentSearch object
    Future<Search> analyzeImageAndText(File image, String foodName) async {
      // Implement your logic to analyze the image and text here
      // ...

      // Return the result as a RecentSearch object

      Search sampleSearch = Search(
          productName: foodName,
          productImage: image,  // Replace with actual image URL
          productInfo: ProductInfo(
            servingSize: "2 oz (56g)",
            date: DateTime.now(),
            ingredients: [
              Ingredient(
                name: "Organic Whole Wheat Flour",
                scientificName: "Triticum aestivum",
                function: "Main ingredient",
                source: "USA",
                healthImplications: "Good source of fiber",
                sustainability: "Sustainably farmed",
                isOrganic: true,
                isGMO: false,
                isFairTrade: false,
              ),Ingredient(
                name: "Organic Whole Wheat Flour",
                scientificName: "Triticum aestivum",
                function: "Main ingredient",
                source: "USA",
                healthImplications: "Good source of fiber",
                sustainability: "Sustainably farmed",
                isOrganic: true,
                isGMO: false,
                isFairTrade: false,
              )
            ],
            nutritionalInfo: NutritionalInfo(
              servingSize: "2 oz (56g)",
              calories: 200,
              macronutrients: [
                MacroNutrient(name: "Total Fat", amount: "1g"),
                MacroNutrient(name: "Protein", amount: "7g"),
                MacroNutrient(name: "Total Carbohydrates", amount: "42g"),
              ],
              micronutrients: [
                MicroNutrient(name: "Iron", amount: "8% DV"),
              ],
              dailyValuePercentage: {"Iron": "8%", "Calcium": "2%"},
              addedSugar: 0,
              naturalSugar: 2,
              sugarAlcohol: 0,
            ),
            tags: ["organic", "whole wheat", "vegan"],
            categories: ["pasta", "grains"],
            labels: ["USDA Organic"],
            allergens: ["Wheat"],
            diets: ["Vegetarian", "Vegan"],
            healthLabels: ["Good source of fiber"],
            cautions: [],
          )
      );

      return sampleSearch;
    }

    final Search result =
        await analyzeImageAndText(_image!, _foodNameController.text);

    // Add the search result to the recent searches
    ref.read(recentSearchesProvider.notifier).addSearch(result);

    // Navigate to DetailsScreen
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(search: result),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Image'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display the selected image
              if (_image != null) Image.file(_image!),
              const SizedBox(height: 20),
              // Capture button
              ElevatedButton(
                onPressed: _getImage,
                child: const Text('Capture Image'),
              ),
              const SizedBox(height: 20),
              // Text field for food name
              TextField(
                controller: _foodNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter food name (optional)',
                ),
              ),
              const SizedBox(height: 20),
              // Analyze button
              ElevatedButton(
                onPressed: _analyzeImage,
                child: const Text('Analyze Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
