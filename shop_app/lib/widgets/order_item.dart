import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../provider/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;
  const OrderItem(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${order.amount.toStringAsFixed(2)}"),
            subtitle: Text(DateFormat("y-MM-dd hh:mm:ss").format(order.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {

              },
            ),
          )
        ],
      ),
    );
  }
}
