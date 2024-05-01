import 'package:flutter/material.dart';
import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/widgets/ingredient_tile.dart';
import 'package:food_spotlight/widgets/nutritional_info_card.dart';

class DetailsScreen extends StatelessWidget {
  final Search search;

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
            Image.file(search.productImage),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Ingredients:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            // Display ingredients using IngredientTile
            ...search.productInfo.ingredients.map(
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
              nutritionalInfo: search.productInfo.nutritionalInfo,
            ),
          ],
        ),
      ),
    );
  }
}
