import 'package:flutter/material.dart';
import 'package:food_spotlight/models/nutritional_info.dart';

import 'package:food_spotlight/models/search.dart';
import 'package:food_spotlight/screens/chat_screen.dart';
import 'package:food_spotlight/widgets/ingredients_list_widget.dart';
import 'package:food_spotlight/widgets/macro_nutrients_widget.dart';

class DetailsScreen extends StatelessWidget {
  final Search search;

  const DetailsScreen({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
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
        label: const Text('Ask Questions'),
        icon: const Icon(Icons.question_answer_outlined),
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
                  MacroNutrientsWidget(
                    size: size,
                    search: search,
                    nutritionalInfo: search.productInfo.nutritionalInfo,
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  CategoryWidget(size: size, search: search),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  MicroNutrientsWidget(
                    size: size,
                    search: search,
                    nutritionalInfo: search.productInfo.nutritionalInfo,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
          width: size.width * .3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.cyan.shade200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Allergies",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              if (search.productInfo.allergens.isEmpty)
                const Text(
                  "Not allergic",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              if (search.productInfo.allergens.isNotEmpty)
                ...search.productInfo.allergens.map(
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
          padding: const EdgeInsets.all(10),
          width: size.width * .25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.orange.shade100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Health Labels",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              if (search.productInfo.healthLabels.isEmpty)
                const Text(
                  "No Health Labels",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              if (search.productInfo.allergens.isNotEmpty)
                ...search.productInfo.healthLabels.map(
                  (e) => Text(
                    e,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
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
              color: Colors.yellowAccent.shade100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Cautions",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              if (search.productInfo.cautions.isEmpty)
                const Text(
                  "No Cautions",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              if (search.productInfo.cautions.isNotEmpty)
                ...search.productInfo.healthLabels.map(
                  (e) => Text(
                    e,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

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
