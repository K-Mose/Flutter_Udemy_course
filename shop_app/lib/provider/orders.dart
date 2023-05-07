import 'package:flutter/foundation.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});

  @override
  String toString() {
    return 'OrderItem{id: $id, amount: $amount, products: $products, dateTime: $dateTime}';
  }
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders => [..._orders];

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()
        )
    );
    notifyListeners();
  }

  @override
  String toString() {
    return 'Orders{_orders: $_orders}';
  }
}
