import 'package:flutter/material.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Lato',
          colorScheme: ThemeData.light().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.deepOrange,
              ),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
        });
  }
}
