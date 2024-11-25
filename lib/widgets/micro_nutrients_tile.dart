
import 'package:flutter/material.dart';
import 'package:food_spotlight/models/nutritional_info.dart';

class MicroNutrientsTile extends StatelessWidget {
  final MicroNutrient microNutrient;

  const MicroNutrientsTile({super.key, required this.microNutrient});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${microNutrient.name} : ${microNutrient.amount}",
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}