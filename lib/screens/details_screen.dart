import 'package:flutter/material.dart';
import 'package:food_spotlight/models/nutritional_info.dart';

import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/screens/chat_screen.dart';
import 'package:food_spotlight/widgets/ingredients_list_widget.dart';

class DetailsScreen extends StatelessWidget {
  final Search search;

  const DetailsScreen({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          String responseText = search.responseText;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                contextText: responseText,
                productName: search.productName,
              ),
            ),
          );
        },
        child: const Icon(Icons.chat),
      ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green,
            iconTheme: const IconThemeData(color: Colors.white),
            expandedHeight: size.height * .25,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                search.productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    search.productImage,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .03,
                  ),
                  IngredientsListWidget(
                    ingredients: search.productInfo.ingredients,
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  NutrientsWidget(
                    size: size,
                    search: search,
                    nutritionalInfo: search.productInfo.nutritionalInfo,
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  CategoryWidget(size: size, search: search)
                ],
              ),
            ),
          )
        ],
      ),
      // appBar: AppBar(
      //   title: Text(search.productName),
      // ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Image.file(search.productImage),
      //       const Padding(
      //         padding: EdgeInsets.all(16.0),
      //         child: Text(
      //           'Ingredients:',
      //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      //         ),
      //       ),
      //       // Display ingredients using IngredientTile
      //       ...search.productInfo.ingredients.map(
      //         (ingredient) => IngredientTile(ingredient: ingredient),
      //       ),
      //       const Padding(
      //         padding: EdgeInsets.all(16.0),
      //         child: Text(
      //           'Nutritional Information:',
      //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      //         ),
      //       ),
      //       // Display nutritional information using NutritionalInfoCard
      //       NutritionalInfoCard(
      //         nutritionalInfo: search.productInfo.nutritionalInfo,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.size,
    required this.search,
  });

  final Size size;
  final Search search;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: size.width * .25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.yellow.shade300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Allergies"),
              if (search.productInfo.allergens.isEmpty)
                const Text("Not allergic"),
              if (search.productInfo.allergens.isNotEmpty)
                ...search.productInfo.allergens.map(
                  (e) => Text(
                    e,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: size.width * .25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.orange.shade100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Health Labels"),
              if (search.productInfo.healthLabels.isEmpty) const Text("No"),
              if (search.productInfo.allergens.isNotEmpty)
                ...search.productInfo.healthLabels.map(
                  (e) => Text(
                    e,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          width: size.width * .25,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.shade300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Cautions"),
              if (search.productInfo.cautions.isEmpty)
                const Text("No Cautions"),
              if (search.productInfo.cautions.isNotEmpty)
                ...search.productInfo.healthLabels.map(
                  (e) => Text(
                    e,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class NutrientsWidget extends StatelessWidget {
  const NutrientsWidget(
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: search.productInfo.diets
                              .map((e) => Text(
                                    e,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Container(
                        width: size.width * .25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.red.shade100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Calories : ${nutritionalInfo.calories}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            ...nutritionalInfo.macronutrients.map(
                              (macroNutrient) => MacroNutrientTile(
                                macroNutrient: macroNutrient,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * .25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue.shade300),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: search.productInfo.tags
                              .map((e) => Text(
                                    e,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                              .toList(),
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
