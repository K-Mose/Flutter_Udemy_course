import 'package:flutter/material.dart';
import 'package:new_meal_ap/model/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({Key? key, required this.category, required this.selectedItem}) : super(key: key);

  final Category category;
  final void Function() selectedItem;

  @override
  Widget build(BuildContext context) {
    // Gesture Detector Widget
    return InkWell(
      onTap: selectedItem,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.7),
                category.color.withOpacity(0.95)
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
