import 'dart:io';

import 'package:food_spotlight/models/ingredient.dart';
import 'package:food_spotlight/models/nutritional_info.dart';

class RecentSearch {
  final String productName;
  final File ingredientImage;
  final List<Ingredient> ingredients;
  final NutritionalInfo nutritionalInfo;

  RecentSearch({
    required this.productName,
    required this.ingredientImage,
    required this.ingredients,
    required this.nutritionalInfo,
  });
}