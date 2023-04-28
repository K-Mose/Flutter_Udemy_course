import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/product.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // const ProductItem(
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  //   {super.key}
  // );

  @override
  Widget build(BuildContext context) {
    /*
    리스너 방식
    Provider.of -> 전체 위젯 rebuild
    Consumer -> 하위 위젯을 consumer로 생성, 해당 부분만 rebuild
    */
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              // context / product(provider 객체) / child (rebuild 될 객체)
              builder: (_, product, child) => IconButton(
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () => {product.changeFavoriteStatus()},
                color: Theme.of(context).accentColor,
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => {
                cart.addItem(product.id, product.price, product.title)
              },
              color: Theme.of(context).accentColor,
              ),
          ),
          child: GestureDetector(
            onTap: () {
              // 현재 스크린에 없는 상태를 가져올 수 없음. 
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (ctx) => ProductDetailScreen(title, price)
              // ));
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName, 
                arguments: product.id,
              );
            },
            child: product.imageUrl.isNotEmpty ? Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ) : const SizedBox(child: Text("")),
          ),
        ),
    );
  }

}