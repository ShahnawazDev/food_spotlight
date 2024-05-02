import 'package:flutter/material.dart';
import 'package:food_spotlight/widgets/food_item_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_spotlight/providers/recent_searches_provider.dart';
import 'package:food_spotlight/screens/capture_image_screen.dart';

import '../widgets/custome_app_bar.dart';
// ... import your UI components (e.g., IngredientTile)

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearches = ref.watch(recentSearchesProvider);
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyy').format(now);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * .08,
          ),
          const CustomeAppBar(
            userName: "Ankit",
          ),
          Expanded(
            child: recentSearches.isEmpty
                ? const Center(
                    child: Text('No recent searches yet.'),
                  )
                : ListView.builder(
                    itemCount: recentSearches.length,
                    itemBuilder: (context, index) {
                      final search = recentSearches[index];
                      return FoodListItems(search: search, size: size, formattedDate: formattedDate,index: index,);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CaptureImageScreen()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}


