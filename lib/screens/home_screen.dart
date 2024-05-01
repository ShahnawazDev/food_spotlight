import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_spotlight/providers/recent_searches_provider.dart';
import 'package:food_spotlight/screens/capture_image_screen.dart';
import 'package:food_spotlight/screens/details_screen.dart';
// ... import your UI components (e.g., IngredientTile)

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearches = ref.watch(recentSearchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Spotlight'),
      ),
      body: recentSearches.isEmpty
          ? const Center(
        child: Text('No recent searches yet.'),
      )
          : ListView.builder(
        itemCount: recentSearches.length,
        itemBuilder: (context, index) {
          final search = recentSearches[index];
          return ListTile(
            leading: Image.file(search.productImage),
            title: Text(search.productName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(search: search),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CaptureImageScreen()),
          );
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}