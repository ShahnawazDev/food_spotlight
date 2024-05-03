



import 'package:flutter/material.dart';
import 'package:food_spotlight/models/nutritional_info.dart';
import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/widgets/micro_nutrients_tile.dart';

class MicroNutrientsWidget extends StatelessWidget {
  const MicroNutrientsWidget({
    super.key,
    required this.size,
    required this.search,
    required this.nutritionalInfo,
  });

  final Size size;
  final Search search;
  final NutritionalInfo nutritionalInfo;

  @override
  Widget build(BuildContext context) {
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
                "MICRONUTRIENTS",
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
          height: size.height * .01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: size.width * .4,
              height: size.height * .17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.height * .25),
                  color: Colors.cyan.shade200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Micro Nutrients",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  if (nutritionalInfo.micronutrients.isEmpty)
                    const Text(
                      "No Nutrients",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                  if (nutritionalInfo.micronutrients.isNotEmpty)
                    ...nutritionalInfo.micronutrients.map(
                          (microNutrient) =>
                          MicroNutrientsTile(microNutrient: microNutrient),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: size.width * .4,
              height: size.height * .17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.height * .25),
                  color: Colors.cyan.shade200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Nutrients Categories",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  if (search.productInfo.categories.isEmpty)
                    const Text(
                      "No Data",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                  if (search.productInfo.categories.isNotEmpty)
                    ...search.productInfo.categories.map(
                          (e) => Text(
                        e,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}