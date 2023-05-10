import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16
        ),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${expense.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.alarm),
                    const SizedBox(width: 8,),
                    Text(expense.date.toString())
                  ],
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}
