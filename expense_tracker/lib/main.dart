import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      // material3 사용
      theme: ThemeData(useMaterial3: true),
      home: const Expenses(),
    )
  );
}