import 'package:flutter/foundation.dart';

// Data Class에 ChangeNotifier 등록, isFavorite 값 변경 시 ChangeNotifier에서 알림
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false
  });

  void changeFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}