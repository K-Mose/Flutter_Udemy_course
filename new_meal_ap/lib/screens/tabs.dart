import 'package:flutter/material.dart';
import 'package:new_meal_ap/providers/favorites_provider.dart';
import 'package:new_meal_ap/providers/filter_provider.dart';
import 'package:new_meal_ap/providers/meal_provider.dart';
import 'package:new_meal_ap/screens/categories.dart';
import 'package:new_meal_ap/screens/filters.dart';
import 'package:new_meal_ap/screens/meals.dart';
import 'package:new_meal_ap/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabsScreen> {
  // 네비게이션의 초기 인덱스 값 설정
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "/filter") {
      /*// push된 화면에서 pop으로 전달받은 데이터를 Future<T>으로 받음
       final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (context) => const FilterScreen(),)
      );*/
       await Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => const FilterScreen(),)
       );
    }
  }

  get _getTitle => (_selectedPageIndex == 0) ? "Categories" : "Your Favorites";
  @override
  Widget build(BuildContext context) {
    // ref - provider 사용 리스너
    final availableMeals = ref.watch(filteredMealsProvider);
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    Widget activePage = (_selectedPageIndex == 0) ?
    CategoriesScreen(availableMeals: availableMeals) :
      MealsScreen(
        meals: favoriteMeals,
      );
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen
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