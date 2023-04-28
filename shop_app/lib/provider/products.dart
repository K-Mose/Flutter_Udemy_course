import 'package:flutter/material.dart';

import 'product.dart';

/*
Inheritance - extends 
Mixin - with 
*/
class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p5',
      title: 'Blue Sweater',
      description: 'Stay cozy with this soft blue sweater.',
      price: 39.99,
      imageUrl: '',
    ),
    Product(
      id: 'p6',
      title: 'Leather Jacket',
      description: 'A sleek and stylish leather jacket for any occasion.',
      price: 99.99,
      imageUrl: ''
    ),
    Product(
      id: 'p7',
      title: 'Sunglasses',
      description: 'Protect your eyes in style with these fashionable sunglasses.',
      price: 19.99,
      imageUrl: '',
    ),
    Product(
      id: 'p8',
      title: 'Running Shoes',
      description: 'Stay active with these comfortable and supportive running shoes.',
      price: 79.99,
      imageUrl: 'https://cdn.pixabay.com/photo/2014/05/18/11/26/shoes-346986_960_720.jpg',
    ),
    Product(
      id: 'p9',
      title: 'Wristwatch',
      description: 'Keep track of time in style with this elegant wristwatch.',
      price: 129.99,
      imageUrl: '',
    ),
    Product(
      id: 'p10',
      title: 'Wireless Headphones',
      description: 'Listen to music or take calls wirelessly with these high-quality headphones.',
      price: 149.99,
      imageUrl: '',
    ),
    Product(
      id: 'p11',
      title: 'Blue Jeans',
      description: 'A classic pair of blue jeans that will never go out of style.',
      price: 49.99,
      imageUrl: '',
    ),
    Product(
      id: 'p12',
      title: 'Black T-Shirt',
      description: 'A simple and versatile black t-shirt for everyday wear.',
      price: 19.99,
      imageUrl: '',
    ),
    Product(
      id: 'p13',
      title: 'Leather Wallet',
      description: 'Keep your cards and cash organized with this stylish leather wallet.',
      price: 39.99,
      imageUrl: '',
    ),
    Product(
      id: 'p14',
      title: 'Hiking Backpack',
      description: 'Take everything you need for a day hike in this spacious and durable backpack.',
      price: 69.99,
      imageUrl: '',
    )
  ];

  List<Product> get items {
    // _item을 복사한 객체를 리턴
    return [..._items];
  }

  List<Product> get favoritItems {
    // _item을 복사한 객체를 리턴
    return _items.where((p) => p.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prd) => prd.id == id);
  }

  void addProduct(Product item) {
    _items.add(item);
    // 현재 provider의 모든 Listener에게 알림
    notifyListeners(); 
  }
}