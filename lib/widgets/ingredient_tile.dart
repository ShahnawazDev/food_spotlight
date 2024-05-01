import 'package:flutter/material.dart';
import 'package:food_spotlight/models/ingredient.dart';

class IngredientTile extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientTile({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ingredient.name),
      subtitle: Text(ingredient.function),
      trailing: const Icon(Icons.info_outline),
      onTap: () {
        // TODO: Implement navigation to detailed ingredient information
        // You might want to create a separate screen or show a dialog
        // with more details about the ingredient (source, health implications, etc.)
      },
    );
  }
}