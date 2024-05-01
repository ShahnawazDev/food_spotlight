import 'package:flutter/material.dart';
import 'package:food_spotlight/models/recent_search.dart';
import 'package:food_spotlight/widgets/ingredient_tile.dart';
import 'package:food_spotlight/widgets/nutritional_info_card.dart';

class DetailsScreen extends StatelessWidget {
  final RecentSearch search;

  const DetailsScreen({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(search.productName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(search.ingredientImage),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Ingredients:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            // Display ingredients using IngredientTile
            ...search.ingredients.map(
              (ingredient) => IngredientTile(ingredient: ingredient),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Nutritional Information:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            // Display nutritional information using NutritionalInfoCard
            NutritionalInfoCard(
              nutritionalInfo: search.nutritionalInfo,
            ),
          ],
        ),
      ),
    );
  }
}
