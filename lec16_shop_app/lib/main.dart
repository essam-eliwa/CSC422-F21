import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lec16_shop/providers/cart.dart';
import 'package:lec16_shop/screens/cart_screen.dart';
import 'package:lec16_shop/screens/products_overview_screen.dart';
import 'package:lec16_shop/screens/product_detail_screen.dart';
import 'package:lec16_shop/providers/products.dart';
import 'package:lec16_shop/providers/orders.dart';
import 'package:lec16_shop/providers/auth.dart';
import 'package:lec16_shop/screens/orders_screen.dart';
import 'package:lec16_shop/screens/user_products_screen.dart';
import 'package:lec16_shop/screens/edit_product_screen.dart';
import 'package:lec16_shop/screens/auth_screen.dart';
import 'package:lec16_shop/screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Auth(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider<Auth, Products?>(
          create: (_) => Products(
              Provider.of<Auth>(context, listen: true).token,
              Provider.of<Auth>(context, listen: true).userId, []),
          update: (ctx, auth, products) =>
              products!..receiveToken(auth, products.items!),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(Provider.of<Auth>(context, listen: false).token,
              Provider.of<Auth>(context, listen: false).userId, []),
          update: (ctx, auth, previousOrders) =>
              previousOrders!..receiveToken(auth, previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MIU-Shop',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen(auth.userName)
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, autResSnapshot) =>
                      autResSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
