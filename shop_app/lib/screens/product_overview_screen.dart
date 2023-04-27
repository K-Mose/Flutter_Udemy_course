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

class ProductOverviewScreen extends StatefulWidget {  
  
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (filter selectedValue) {
              setState(() {
                if(selectedValue == filter.All) {
                    _showOnlyFavorites = false;
                  
                } else if(selectedValue == filter.Favorites) {
                    _showOnlyFavorites = true;
                }
              });
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
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}

