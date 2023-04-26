import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final Function deleteTrx;
  TransactionList(this._userTransaction, this.deleteTrx);

  @override
  Widget build(BuildContext context) {
    return _userTransaction.isEmpty ? 
    LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          Text(
            "No transactions added yet!",
            style: Theme.of(context).textTheme.titleLarge
          ),
          SizedBox(
            height: constraint.maxHeight * 0.15,
          ),
          Container(
            height: constraint.maxHeight * 0.6,
            child: Image.asset(
              "assets/images/waiting.png",
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    })
     : 
     ListView(
      children: _userTransaction.map((tx) {
        return TransactionItem(
            key: ValueKey(tx.id),
            deleteTrx: deleteTrx, 
            tx: tx
          );
      }).toList(),
     );
    //   ListView.builder(
    //     itemBuilder: (context, index) {
    //       final tx = _userTransaction[index];
    //       return TransactionItem(
    //         key: UniqueKey(),
    //         deleteTrx: deleteTrx, 
    //         tx: tx
    //       );
    //     },
    //     itemCount: _userTransaction.length,
    // );
  }
}
/*
Card(
              child: Row(children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor, 
                    width: 2
                  )
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                '\$ ${tx.amount.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor, 
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: Theme.of(context).textTheme.titleLarge
                  // TextStyle(
                  //   fontSize: 16, 
                  //   fontWeight: FontWeight.bold
                  // ),
                ),
                Text(
                  DateFormat('yyyy-MM-dd hh:mm:ss').format(tx.date),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )
          ]));
*/