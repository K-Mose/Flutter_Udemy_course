import 'package:flutter/material.dart';
import 'package:new_meal_ap/data/dummy_data.dart';
import 'package:new_meal_ap/model/meal.dart';
import 'package:new_meal_ap/screens/categories.dart';
import 'package:new_meal_ap/screens/meals.dart';
import 'package:new_meal_ap/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {

  @override
  State createState() => _TabScreenState();
}

class _TabScreenState extends State<TabsScreen> {
  // 네비게이션의 초기 인덱스 값 설정
  int _selectedPageIndex = 0;

  final List<Meal> _favoriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String message) {
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
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal) ? {
        _showInfoMessage("Meal is no longer a favorite."),
        _favoriteMeals.remove(meal)
      } : {
        _showInfoMessage("Marked as a favorite!"),
        _favoriteMeals.add(meal)
      };
    });
  }

  get _getTitle => (_selectedPageIndex == 0) ? "Categories" : "Your Favorites";
  @override
  Widget build(BuildContext context) {
    Widget activePage = (_selectedPageIndex == 0) ?
    CategoriesScreen(toggleMealFavoriteStatus: _toggleMealFavoriteStatus,) :
      MealsScreen(meals: _favoriteMeals, toggleMealFavoriteStatus: _toggleMealFavoriteStatus,);
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle),
      ),
      drawer: const MainDrawer(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        // 선택된 아이템의 인덱스를 인자로 받음
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Recipe"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorite"),
        ],
      ),
    );
  }
}