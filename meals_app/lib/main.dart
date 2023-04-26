import 'package:flutter/material.dart';
import 'package:meals_app/screens/error_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

import '/screens./categories_screen.dart';
import './screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
        
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.yellow,
      canvasColor: Color.fromRGBO(255, 255, 255, 1),
      fontFamily: 'Raleway',
      textTheme: ThemeData.light().textTheme.copyWith(
        bodyLarge: const TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1)
        ),
        bodyMedium: const TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1)
        ),
        bodySmall: const TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1)
        ),
        titleLarge:const TextStyle(
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold
        ), 
      ),
      appBarTheme: AppBarTheme.of(context).copyWith(
        color: Colors.pink[300]
      )
    );

    return MaterialApp(
      title: 'Meals App',
      theme: theme.copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          secondary: Colors.amber,
        ),
      ),
      // home: const CategoriesScreen(),
      routes: {
        // '/'를 라우팅하면 home 페이지로 설정
        '/' :(context) => const CategoriesScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },
      /*
      // routes에 정의되지 않은 named route의 셋팅과 정보, 라우팅 페이지를 리턴 함
      onGenerateRoute: (settings) {
        print(settings.name);
        print(settings.arguments);
        if (settings.name == "/somePage") {
          return MaterialPageRoute(builder: (context) => const CategoriesScreen());
        }
        return null;
      },
      // onGenerateRoute에서 유효하지 않은 라우팅을 하게되면 호출됨
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
      }, */
    );
  }
}
