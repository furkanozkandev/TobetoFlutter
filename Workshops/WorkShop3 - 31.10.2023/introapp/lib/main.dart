import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
    return MaterialApp(
      home: Scaffold(
        backgroundColor:
            Color.fromARGB(255, 130, 86, 163), //Configuration Widget
        appBar: AppBar(
          title: Text('Tobeto Kart'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/furkanozkan.jpg"),
              const Text(
                'Furkan Özkan',
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              const Text(
                'Tobeto - Mobil Geliştirici - 1B',
                style: TextStyle(
                    fontSize: 27, color: Color.fromARGB(255, 209, 206, 39)),
              ),
              Text('Bugünün Tarihi: $currentDate',
                  style: TextStyle(
                      fontSize: 24, color: Color.fromARGB(255, 77, 226, 226))),
            ],
          ),
        ),
      ),
    );
  }
}
