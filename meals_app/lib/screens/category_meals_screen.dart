import 'package:flutter/material.dart';
import 'package:meals_app/dummy.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen({
  //   required this.categoryId,
  //   required this.categoryTitle
  // });

  @override
  Widget build(BuildContext context) {
    // ModalRoute - material.dart에서 제공하는 라우팅 
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return (meal.categories).contains(routeArgs['id']);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs['title']!),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title, 
            imageUrl: categoryMeals[index].imageUrl, 
            duration: categoryMeals[index].duration, 
            complexity: categoryMeals[index].complexity, 
            affordability: categoryMeals[index].affordability
          );
        },
        itemCount: categoryMeals.length,
      )
    );
  }
}