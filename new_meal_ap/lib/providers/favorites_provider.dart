import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_meal_ap/data/dummy_data.dart';
import 'package:new_meal_ap/model/meal.dart';

// 데이터 변화에 최적화된 Provider (상태관리)
final favoriteMealsProvider =
  StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
    (ref) => FavoriteMealsNotifier()
  );

//StateNotifierProvider는 StateNotifier를 상속받는 클래스와 같이 사용함
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // initial value
  FavoriteMealsNotifier() : super([]); // notifier에 저장할 초기 데이터 super에 전달

  // Immediately invoking an anonymous function (){...}()
  bool toggleMealFavoriteStatus(Meal meal) =>
      // 상태는 불변값이므로 상태에 대하여 add나 remove등을 할 수 없다.
      // -> 상태에 값을 재할당
      (!state.contains(meal)) ? () {
        state = [...state, meal];
        return true;
      }() : () {
        state = state.where((m) => m.id != meal.id).toList();
        return false;
      }();
}