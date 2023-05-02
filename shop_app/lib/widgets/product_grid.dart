import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    // Listener connect with Provider
    final productsData = Provider.of<Products>(context);
    final products = showFavoriteOnly? productsData.favoritItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // create: (c) => products[index],
        // 미리 생성된 값을 value에 넣음
        value: products[index],
        child: ProductItem(
          // products[index].id,
          // products[index].title,
          // products[index].imageUrl,
        ),
      ) ,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // column count
        childAspectRatio:  3 / 2, // child width hight ratio
        crossAxisSpacing: 10, // space between columns
        mainAxisSpacing: 10 // sapce between rows
      ),
    );
  }
}