import 'package:flutter/material.dart';
import 'package:new_meal_ap/model/meal.dart';
import 'package:new_meal_ap/screens/meal_detail_screen.dart';
import 'package:new_meal_ap/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({Key? key, this.title, required this.meals})
      : super(key: key);

  final String? title;
  final List<Meal> meals;
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealDetailScreen(selectedMeal: meal)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = meals.isNotEmpty ?
      ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            return MealItem(
              meal: meals[index],
              selectMeal: (meal) {
                selectMeal(context, meal);
              },
            );
          })
        : Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(" Nothing in Here! ",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
            )),
          const SizedBox(height: 16,),
          Text('Try selecting a different category!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground
          ),)
        ],
      ),
    );
    return (title == null) ? content : Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
