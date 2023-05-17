import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.expenses}) : super(key: key);

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
   return [
     ExpenseBucket.forCategory(expenses, Category.leisure),
     ExpenseBucket.forCategory(expenses, Category.work),
     ExpenseBucket.forCategory(expenses, Category.travel),
     ExpenseBucket.forCategory(expenses, Category.food),
   ];
  }

  double get maxTotalExpense =>
      buckets.fold(0, (p, bucket) => p > bucket.totalExpenses ? p : bucket.totalExpenses);

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets.map((bucket) =>
                  ChartBar(  fill: bucket.totalExpenses == 0
                    ? 0
                    : bucket.totalExpenses / maxTotalExpense, )).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    categoryIcons[bucket.category],
                    color: isDarkMode
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.7),
                  ),
                ),
              ),
            )
                .toList(),
          )
        ],
      ),
    );
  }
}
