import 'package:flutter/cupertino.dart';

import 'package:expense_tracker/model/expense.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: ObjectKey(expenses),
      // shrinkWrap: true, // unbounded height error
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Text(expenses[index].title);
      },
    );
  }
}
