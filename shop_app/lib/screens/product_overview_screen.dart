import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';
import '../wigets/product_grid.dart';
import '../wigets/product_item.dart';
import '../provider/product.dart';

enum FilterOptions {
  Favorites,
  All
}

typedef filter = FilterOptions;

class ProductOverviewScreen extends StatelessWidget {  
  
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (filter selectedValue) {
              if(selectedValue == filter.All) {
                productsContainer.showAll();
              } else if(selectedValue == filter.Favorites) {
                productsContainer.showFavoriteOnly();
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favorites"),
                value: filter.Favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: filter.All,
              ),
            ],
          )
        ],
      ),
      body: ProductGrid(),
    );
  }
}

