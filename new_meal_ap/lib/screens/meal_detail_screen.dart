import 'package:flutter/material.dart';
import 'package:new_meal_ap/model/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({Key? key, required this.selectedMeal}) : super(key: key);
  final Meal selectedMeal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SizedBox(
        width: double.infinity,
        height: 300,
        child: FadeInImage(
          fit: BoxFit.cover,
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(
              selectedMeal.imageUrl
          ),
        ),
      ),
    );
  }
}
