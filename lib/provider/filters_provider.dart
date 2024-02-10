import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymeals/provider/meals_provider.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarianFree,
  veganFree,
}

class FiltersNotifer extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifer()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarianFree: false,
          Filters.veganFree: false,
        });

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifer, Map<Filters, bool>>((ref) {
  return FiltersNotifer();
});

final filtersMealProviders = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((element) {
    if (activeFilters[Filters.lactoseFree]! && !element.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filters.glutenFree]! && !element.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filters.vegetarianFree]! && !element.isVegetarian) {
      return false;
    }
    if (activeFilters[Filters.veganFree]! && !element.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
