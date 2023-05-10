import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
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
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Hamburger",
        amount: 9.98,
        date: DateTime(2023, 4, 15),
        category: Category.food
    ),
    Expense(
      title: "Airfare",
      amount: 250.0,
      date: DateTime(2023, 4, 15),
      category: Category.travel,
    ),
    Expense(
      title: "Movie Tickets",
      amount: 25.5,
      date: DateTime(2023, 4, 20),
      category: Category.leisure,
    ),
    Expense(
      title: "Office Supplies",
      amount: 50.75,
      date: DateTime(2023, 4, 25),
      category: Category.work,
    ),
    Expense(
      title: "Dinner",
      amount: 45.99,
      date: DateTime(2023, 4, 27),
      category: Category.food,
    ),
    Expense(
      title: "Hotel Accommodation",
      amount: 150.0,
      date: DateTime(2023, 4, 30),
      category: Category.travel,
    ),
    Expense(
      title: "Coffee",
      amount: 3.5,
      date: DateTime(2023, 5, 1),
      category: Category.food,
    ),
    Expense(
      title: "Concert Tickets",
      amount: 75.0,
      date: DateTime(2023, 5, 3),
      category: Category.leisure,
    ),
    Expense(
      title: "Taxi Fare",
      amount: 20.0,
      date: DateTime(2023, 5, 5),
      category: Category.travel,
    ),
    Expense(
      title: "Lunch",
      amount: 15.99,
      date: DateTime(2023, 5, 7),
      category: Category.food,
    ),
    Expense(
      title: "Conference Registration",
      amount: 200.0,
      date: DateTime(2023, 5, 10),
      category: Category.work,
    ),
    Expense(
      title: "Gym Membership",
      amount: 50.0,
      date: DateTime(2023, 5, 12),
      category: Category.leisure,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Expense Tracker"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add)
            )
          ],
        ),
        body: Column(
          children: [
            const Text("The chart"),
            Expanded(child: ExpensesList(expenses: _registeredExpenses))
          ],
        ),
      ),
    );
  }
}