import 'package:flutter/material.dart';


/*
// StatfulWidget - 상태(State)변경에 따라 업데이트 되는 위젯
1. StatefulWidget을 상속받는 위젯 클래스 Expenses
2. State를 관리하는 상태 클래스 _Expenses
 */
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Expense"),),
      body: Column(
        children: const [
          Text("The chart")
        ],
      ),
    );
  }
}