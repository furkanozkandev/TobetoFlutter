import 'package:myexpenseapp/pages/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(useMaterial3: true), debugShowCheckedModeBanner: false, home: const MainPage()));
}
