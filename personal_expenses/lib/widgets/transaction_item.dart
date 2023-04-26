
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  @required final Function deleteTrx;
  @required final Transaction tx;
  TransactionItem({
    key, 
    this.deleteTrx, 
    this.tx
  }): super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    final availableColor = [
      Colors.black,
      Colors.blueGrey,
      Colors.yellow,
      Colors.blue,
      Colors.red,
    ];
    _bgColor = availableColor[Random().nextInt(availableColor.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function deleteTrx = widget.deleteTrx;
    final Transaction tx = widget.tx;
    return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _bgColor,
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text('\$ ${tx.amount.toString()}')
                  ),
                ),
              ),
              title: Text(
                tx.title, 
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(DateFormat.yMMMd().format(tx.date)),
              // 화면 너비에 따른 설정하는 법 
              trailing: MediaQuery.of(context).size.width > 460 ?
              TextButton.icon(
                onPressed: () => deleteTrx(tx.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error
                  ),
                )
              )
              : IconButton(
                onPressed: () => deleteTrx(tx.id),
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
  }
}