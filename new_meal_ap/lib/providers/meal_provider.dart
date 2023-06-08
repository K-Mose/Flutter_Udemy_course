import 'package:new_meal_ap/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// create provider. 변하지 않는 값은 단순 Provider로 제공
final mealsProvider = Provider((ref) {
  // _createFn -> Provider로 관리할 객체
  return dummyMeals;
});