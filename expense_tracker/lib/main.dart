import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme //
    .fromSeed(seedColor: const Color.fromARGB(255, 123, 55, 1));

var kDarkColorScheme = ColorScheme
    .fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 80, 25, 1)
);

void main() {
  // 앱의 화면 허용 방향 설정 > 화면 rotation 방지
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp
  // ]).then((fn) =>
  // {
    runApp(
        MaterialApp(
          // material3 사용
          darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            appBarTheme: const AppBarTheme().copyWith(
                centerTitle: true
            ),
            colorScheme: kDarkColorScheme,
            cardTheme: const CardTheme().copyWith(
                color: kDarkColorScheme.secondaryContainer,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kDarkColorScheme.primaryContainer
                )
            ),
          ),
          theme: ThemeData().copyWith(
            useMaterial3: true,
            // scaffoldBackgroundColor: Colors.blueGrey,
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kColorScheme.onPrimaryContainer,
                foregroundColor: kColorScheme.primaryContainer,
                centerTitle: true
            ),
            cardTheme: const CardTheme().copyWith(
                color: kColorScheme.secondaryContainer,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kColorScheme.primaryContainer
                )
            ),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.secondaryContainer,
                    fontSize: 22), // appBar title
                titleMedium: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 14)

            ),
          ),
          // themeMode: ThemeMode.light, // theme 강제 사용
          home: const Expenses(),
        )
    );
  // });
}