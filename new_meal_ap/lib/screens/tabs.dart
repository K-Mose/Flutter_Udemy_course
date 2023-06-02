import 'package:flutter/material.dart';
import 'package:new_meal_ap/data/dummy_data.dart';
import 'package:new_meal_ap/screens/categories.dart';
import 'package:new_meal_ap/screens/meals.dart';

class TabsScreen extends StatefulWidget {

  @override
  State createState() => _TabScreenState();
}

class _TabScreenState extends State<TabsScreen> {
  // 네비게이션의 초기 인덱스 값 설정
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  get _getTitle => (_selectedPageIndex == 0) ? "Categories" : "Your Favorites";
  @override
  Widget build(BuildContext context) {
    Widget activePage = (_selectedPageIndex == 0) ?
      const CategoriesScreen() :
      const MealsScreen(meals: []);
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle),
      ),
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