import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/cupertino.dart';

import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.removeExpense
  });

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      key: ObjectKey(expenses),
      // shrinkWrap: true, // unbounded height error
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ObjectKey(expenses[index]),
        background: Container(
          margin: EdgeInsets.symmetric(
              horizontal: theme.cardTheme.margin!.horizontal
          ),
          color: theme.colorScheme.error,
        ),
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index])
      ),
    );
  }
}
