import 'package:flutter/material.dart';
import 'package:miniblog/screens/homepage.dart';
import 'package:miniblog/screens//blog_detail.dart';

void main() {
  runApp(const MaterialApp(home: Homepage()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Blog Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage(),
    );
  }
}