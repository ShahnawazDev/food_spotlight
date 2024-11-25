
import 'package:flutter/material.dart';
import 'package:food_spotlight/models/search.dart';

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