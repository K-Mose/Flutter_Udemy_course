import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './provider/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider 등록
    // data가 context에 의존하지 않으면 value생성자 사용 가능(재사용 할 때 사용)
    // return ChangeNotifierProvider.value(
    //   value: Products(),
    // create 사용 시 한번 위젯을 생성하고 나면 재생성하지 않음
    // 새로운 인스턴스를 생성하고 제공 할 때 create / 생성된 인스턴스를 재사용 할 때 value
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen()
        },
      ),
    );
  }
}

