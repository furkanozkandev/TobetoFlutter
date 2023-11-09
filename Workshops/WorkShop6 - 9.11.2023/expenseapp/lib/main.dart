import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/pages/expenses_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ExpenseApp'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.add_circle_outline_sharp),
              iconSize: 35,
              onPressed: () {
              },
            ),
          ],
        ),
        body: ExpensesPage(),
      ),
    ),
  );
}
