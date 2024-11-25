import 'package:food_spotlight/models/ingredient.dart';
import 'package:food_spotlight/models/nutritional_info.dart';

class ProductInfo {
  final String servingSize; // Serving size as indicated on packaging (e.g., "2 tablespoons")
  final DateTime date; // Date and time of the search
  final List<Ingredient> ingredients; // List of ingredients in the product
  final NutritionalInfo nutritionalInfo; // Nutritional information of the product
  final List<String> tags; // Tags like "vegan", "gluten-free", etc.
  final List<String> categories; // Categories like "nut butters", "snacks", etc.
  final List<String> labels; // Certification labels like "Organic", "Non-GMO"
  final List<String> allergens; // Potential allergens present
  final List<String> diets; // Suitable diets like "Keto", "Paleo"
  final List<String> healthLabels; // Health claims like "Heart-Healthy"
  final List<String> cautions; // Cautions or warnings

  ProductInfo({
    required this.servingSize,
    required this.date,
    required this.ingredients,
    required this.nutritionalInfo,
    this.tags = const [],
    this.categories = const [],
    this.labels = const [],
    this.allergens = const [],
    this.diets = const [],
    this.healthLabels = const [],
    this.cautions = const [],
  });

  // Second constructor with fewer parameters
  ProductInfo.simple({
    required this.servingSize,
    required this.date,
    required this.ingredients,
    required this.nutritionalInfo,
  })  : tags = [],
        categories = [],
        labels = [],
        allergens = [],
        diets = [],
        healthLabels = [],
        cautions = [];


  Map<String,dynamic> toJson(){
    return {
      'servingSize': servingSize,
      'date': date.toIso8601String(),
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'nutritionalInfo': nutritionalInfo.toJson(),
      'tags': tags,
      'categories': categories,
      'labels': labels,
      'allergens': allergens,
      'diets': diets,
      'healthLabels': healthLabels,
      'cautions': cautions,
    };
  }

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      servingSize: json['servingSize'],
      date: DateTime.parse(json['date']),
      ingredients: (json['ingredients'] as List).map((e) => Ingredient.fromJson(e)).toList(),
      nutritionalInfo: NutritionalInfo.fromJson(json['nutritionalInfo']),
      tags: (json['tags'] as List).map((item) => item.toString()).toList(),
      categories: (json['categories'] as List).map((item) => item.toString()).toList(),
      labels: (json['labels'] as List).map((item) => item.toString()).toList(),
      allergens: (json['allergens'] as List).map((item) => item.toString()).toList(),
      diets: (json['diets'] as List).map((item) => item.toString()).toList(),
      healthLabels: (json['healthLabels'] as List).map((item) => item.toString()).toList(),
      cautions: (json['cautions'] as List).map((item) => item.toString()).toList(),
    );
  }
}
