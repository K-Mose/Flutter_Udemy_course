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
      body: SingleChildScrollView(
        child: Column(
            children: [
              FadeInImage(
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(
                    selectedMeal.imageUrl
                ),
              ),
              const SizedBox(height: 14,),
              Text("Ingredients", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 14,),
              ...selectedMeal.ingredients.map((e) => Text(
                e,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              )).toList(),
              const SizedBox(height: 24,),
              ...selectedMeal.steps.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  e,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground
                  ),
                ),
              )).toList(),
            ]
          ),
      ),
    );
  }
}
