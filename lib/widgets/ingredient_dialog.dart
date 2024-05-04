import 'package:flutter/material.dart';
import 'package:food_spotlight/models/ingredient.dart';

class IngredientDialog extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientDialog({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20), // Rounded corners for the dialog
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ingredient.name,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 20),
            buildInfoRow("Scientific Name", ingredient.scientificName),
            buildInfoRow("Function", ingredient.function),
            buildInfoRow("Source", ingredient.source),
            buildInfoRow("Health Implications", ingredient.healthImplications),
            buildInfoRow("Sustainability", ingredient.sustainability),
            buildInfoRow("Organic", ingredient.isOrganic ? 'Yes' : 'No'),
            buildInfoRow("GMO", ingredient.isGMO ? 'Yes' : 'No'),
            buildInfoRow("Fair Trade", ingredient.isFairTrade ? 'Yes' : 'No'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // Rounded corners for the button
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
