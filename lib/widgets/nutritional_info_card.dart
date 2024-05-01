import 'package:flutter/material.dart';
import 'package:food_spotlight/models/nutritional_info.dart';

class NutritionalInfoCard extends StatelessWidget {
  final NutritionalInfo nutritionalInfo;

  const NutritionalInfoCard({super.key, required this.nutritionalInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calories: ${nutritionalInfo.calories}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Macronutrients:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Use a ListView or Column to display macronutrients
            // ...
            const SizedBox(height: 8),
            const Text(
              'Micronutrients:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Use a ListView or Column to display micronutrients
            // ...
          ],
        ),
      ),
    );
  }
}