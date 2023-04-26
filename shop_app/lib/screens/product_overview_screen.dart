import 'package:flutter/material.dart';
import '../wigets/product_grid.dart';
import '../wigets/product_item.dart';
import '../provider/product.dart';

class ProductOverviewScreen extends StatelessWidget {  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: ProductGrid(),
    );
  }
}

