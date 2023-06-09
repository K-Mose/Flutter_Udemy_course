import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../provider/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import '../widgets/product_grid.dart';
import '../widgets/badges.dart';

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
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badges(
              child: child!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    CartScreen.routeName
                  );
                },
                icon: Icon(Icons.shopping_cart)
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}

