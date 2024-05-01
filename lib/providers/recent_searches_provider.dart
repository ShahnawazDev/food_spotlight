import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_spotlight/models/recent_search.dart';

// Create a StateNotifier for managing recent searches
class RecentSearchesNotifier extends StateNotifier<List<RecentSearch>> {
  RecentSearchesNotifier() : super([]);

  void addSearch(RecentSearch search) {
    // Limit the number of recent searches (e.g., to 10)
    if (state.length >= 10) {
      state = state.sublist(1); // Remove the oldest search
    }
    state = [search, ...state]; // Add new search to the beginning
  }
}

// Create the provider
final recentSearchesProvider =
StateNotifierProvider<RecentSearchesNotifier, List<RecentSearch>>(
        (ref) => RecentSearchesNotifier());