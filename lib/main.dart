import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/order_provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/providers/promotions_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/splash_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';
import 'screens/bottom_navigationBar.dart';
import './providers/products_provider.dart';
import './screens/auth_screen.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (_) => ProductsProvider('', '', []),
          update: (context, auth, previousProducts) => ProductsProvider(
            auth.token ?? '',
            auth.userId ?? '',
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', '',[]),
          update: (context, auth, previousOrders) => Orders(
              auth.token!, 
              auth.userId!,
              previousOrders == null ? [] : previousOrders.orders),
        ),
        ChangeNotifierProvider(
          create: (context) => PromotionsProducts()
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // fontFamily: ,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                .copyWith(secondary: Colors.amber),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android : CustomPageTransitionBuilder(),
              TargetPlatform.iOS : CustomPageTransitionBuilder(),
            })
          ),
          home: auth.isAuth ? BottomNavigation() : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScrenn() : AuthScreen(),
          ),
          //BottomNavigation(),
          routes: {
            ProdukDetailScreen.routeName: (context) =>
                const ProdukDetailScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrderScreen.routeName: (context) => const OrderScreen(),
            UserProductScreen.routeName: (context) => const UserProductScreen(),
            EditProductScreen.routeName: (context) => const EditProductScreen(),
            BottomNavigation.routeName: (context) => const BottomNavigation(),
          },
        ),
      ),
    );
  }
}
