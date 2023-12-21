import 'package:flutter/material.dart';
import 'package:httpexample/screens/products_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
      ThemeData(useMaterial3: true, scaffoldBackgroundColor: Colors.green),
      home: const Scaffold(
        body: ProductsScreen(),
      ),
    );
  }
}