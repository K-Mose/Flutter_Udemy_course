import 'package:flutter/material.dart';

import '../dummy.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10)
      ),            
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);
  
    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title),),
      body: Center(
        child: Column(children: [
          Container(
            height: 300, 
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, "Ingredients"),
          buildContainer(Padding(
              padding: const EdgeInsets.all(8.0), 
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: Theme.of(context).textTheme.titleMedium ,
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            )),
          buildSectionTitle(context, "Steps"),
          buildContainer(ListView.builder(
            itemBuilder: (context, index) => Column(
              children: [ListTile(
                  leading: CircleAvatar(child: Text("# ${index+1}")),
                  title: Text(
                      selectedMeal.steps[index],
                      style: Theme.of(context).textTheme.titleSmall ,
                  ),
                ),
                Divider(color: Colors.grey[300],)
              ]
            ),
            itemCount: selectedMeal.steps.length,
          ))
        ]),
      ),
    );
  }
}