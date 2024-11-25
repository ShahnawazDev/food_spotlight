
import 'package:flutter/material.dart';
import 'package:food_spotlight/models/nutritional_info.dart';
import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/widgets/macro_nutrients_tile.dart';

class  MacroNutrientsWidget extends StatelessWidget {
  const MacroNutrientsWidget(
      {super.key,
        required this.size,
        required this.search,
        required this.nutritionalInfo});

  final Search search;
  final NutritionalInfo nutritionalInfo;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
                "NUTRIENTS",
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
        Container(
          height: size.height * .2,
          width: double.infinity,
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.green.withOpacity(.25),
              borderRadius: BorderRadius.circular(14)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Serving Size : ${nutritionalInfo.servingSize}",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: size.width * .25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.yellow.shade300),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Text(
                               "Diets",
                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                             ),
                             if (search.productInfo.diets.isEmpty)
                               const Text(
                                 "No Data",
                                 style: TextStyle(
                                     fontWeight: FontWeight.w600,
                                     fontSize: 16,
                                     color: Colors.grey),
                               ),
                             if (search.productInfo.diets.isNotEmpty)
                               ...search.productInfo.diets.map(
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
                      Container(
                        width: size.width * .25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.red.shade100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Key Nutrients",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Calories : ${nutritionalInfo.calories}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green),
                            ),

                            ...nutritionalInfo.macronutrients
                                .map((macroNutrient) => MacroNutrientTile(
                                macroNutrient: macroNutrient))
                                ,
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * .25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue.shade100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Text(
                               "Product Traits",
                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                             ),
                             if (search.productInfo.tags.isEmpty)
                               const Text(
                                 "No Data",
                                 style: TextStyle(
                                     fontWeight: FontWeight.w600,
                                     fontSize: 16,
                                     color: Colors.grey),
                               ),
                             if (search.productInfo.tags.isNotEmpty)
                               ...search.productInfo.tags.map(
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
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}