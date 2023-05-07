import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  const CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  List<CartItem> get listItems {
    return _items.values.toList();
  }

  List<String> get listItemKeys {
    return _items.keys.toList();
  }

  int get itemCount {
    return _items.length;
  }
  
  double get totalAmount =>
    _items.values.fold(0.0, (p, n) =>
      p + n.price * n.quantity
    );

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (cardItem) => CartItem(
              id: cardItem.id,
              title: cardItem.title,
              quantity: cardItem.quantity + 1,
              price: cardItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
