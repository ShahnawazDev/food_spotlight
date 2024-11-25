

import 'package:flutter/material.dart';
import 'package:food_spotlight/models/ingredient.dart';
import 'package:food_spotlight/widgets/ingredient_tile_widget.dart';

class IngredientsListWidget extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientsListWidget({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                color: Colors.green,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "INGREDIENTS",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.green),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * .005,
        ),
        for (int i = 0; i < ingredients.length - 1; i += 2)
          Row(
            children: [
              IngredientTileWidget(ingredient: ingredients[i]),
              IngredientTileWidget(ingredient: ingredients[i + 1])
            ],
          ),
      ],
    );
  }
}