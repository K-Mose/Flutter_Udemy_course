import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/Chart_bar.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      double totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        final date = recentTransactions[i].date;
        if(date.day == weekDay.day && 
            date.month == weekDay.month && 
            date.year == weekDay.year) {
              totalSum += recentTransactions[i].amount;
        }
      }

      return {
        "DAY": DateFormat.E().format(weekDay),
        "AMOUNT": totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, data) {
      return sum + data['AMOUNT'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['DAY'], 
                data['AMOUNT'], 
                totalSpending == 0.0 ? 0.0 : (data['AMOUNT'] as double)/totalSpending
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}