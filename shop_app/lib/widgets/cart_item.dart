import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart ';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final Function(String productId) removeItem;
  const CartItem(Key key, this.id, this.productId, this.price, this.quantity, this.title, this.removeItem)
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dismissible( // android SwipeToDismiss
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        )
      ),
      direction: DismissDirection.endToStart, // right to left
      onDismissed: (direction) {
        removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(child: Text("\$$price"))),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text("$quantity"),
          ),
        ),
      ),
    );//
  }
}
