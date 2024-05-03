

import 'package:flutter/cupertino.dart';
import 'package:food_spotlight/models/nutritional_info.dart';

class MacroNutrientTile extends StatelessWidget {
  final MacroNutrient macroNutrient;

  const MacroNutrientTile({super.key, required this.macroNutrient});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${macroNutrient.name}:${macroNutrient.amount}",
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}