import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme //
    .fromSeed(seedColor: const Color.fromARGB(255, 123, 55, 1));

void main() {
  runApp(
    MaterialApp(
      // material3 사용
      theme: ThemeData().copyWith(
        useMaterial3: true,
        // scaffoldBackgroundColor: Colors.blueGrey,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          centerTitle: true
        )
      ),
      home: const Expenses(),
    )
  );
}