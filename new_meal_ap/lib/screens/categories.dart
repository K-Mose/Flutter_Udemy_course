import 'package:flutter/material.dart';
import 'package:new_meal_ap/data/dummy_data.dart';
import 'package:new_meal_ap/model/meal.dart';
import 'package:new_meal_ap/screens/meals.dart';
import 'package:new_meal_ap/widgets/category_grid_item.dart';

import '../model/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.toggleMealFavoriteStatus, required this.availableMeals});
  final Function(Meal meal) toggleMealFavoriteStatus;
  final List<Meal> availableMeals;
  void _selectedCategory(BuildContext context, Category category) {
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => MealsScreen(
      title: category.title,
      meals: availableMeals.where((meal) => meal.categories.contains(category.id)).toList(),
      toggleMealFavoriteStatus: toggleMealFavoriteStatus,
    ))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView(
        // 그리드뷰의 자식들을 컨트롤하는 델리게이터
        // crossAxisCount : Left to right
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // 가로 세로 비율
            childAspectRatio: 3 / 2,
            // 수평방향 수직방향 각각 자식들간의 간격
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(category: category, selectedItem: () {
              _selectedCategory(context, category);
            },)
        ],
      ),
    );
  }
}