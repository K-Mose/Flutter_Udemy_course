import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_meal_ap/providers/meal_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

final filterProvider =
  StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier()
  );

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false
  });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive
    };
  }
}

// Connecting Multiple Provider
final filteredMealsProvider = Provider((ref) {
  // ref는 riverpod 전역에서 사용되는 같은 ref 객체를 공유하기 때문에
  // ref에서 모든 provider에 접근이 가능하다.
  final meals = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filterProvider);
  return meals.where( (meal) =>
  (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) ? false :
  (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) ? false :
  (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) ? false :
  (activeFilter[Filter.vegan]! && !meal.isVegan) ? false : true).toList();
});