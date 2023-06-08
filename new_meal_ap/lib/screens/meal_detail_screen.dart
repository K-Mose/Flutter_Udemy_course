import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_meal_ap/model/meal.dart';
import 'package:new_meal_ap/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

// WidgetRef를 사용하기 위해 ConsumerWidget으로 변경
class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    Key? key,
    required this.selectedMeal,
  }) : super(key: key);

  final Meal selectedMeal;

  @override // ConsumerWidget의 WigdetRef를 통해서 Provider에 접근
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
        actions: [
          IconButton(
            onPressed: () {
              // FavoriteMealsNotifier에 접근하기 위해 provider의 notifier를 호출
              final message = ref.read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(selectedMeal)
                  ? "Meal added as a favorites."
                  : "Meal removed.";
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    action: SnackBarAction(
                      label: "close",
                      onPressed: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                      },
                    ),
                  )
              );
            },
            icon: const Icon(Icons.star)
          )
        ],
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
