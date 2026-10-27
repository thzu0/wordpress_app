import 'package:flutter/material.dart';

import 'package:wordpress_app/UI/home/home_page.dart';
import 'package:wordpress_app/UI/product_details/product_detail.dart';
import 'package:wordpress_app/UI/root/root_page.dart';
import 'package:wordpress_app/provider/loader_provider.dart';
import 'package:wordpress_app/provider/shop_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShopProvider(),
          child: const HomePage(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoaderProvider(),
          child: const ProductDetail(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RootPage(),
      ),
    );
  }
}
