import 'package:new_meal_ap/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// create provider
final mealsProvider = Provider((ref) {
  // _createFn -> Provider로 관리할 객체
  return dummyMeals;
});