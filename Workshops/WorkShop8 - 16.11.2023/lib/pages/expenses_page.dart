import 'package:flutter/material.dart';
import 'package:myexpenseapp/data/data.dart';
import 'package:myexpenseapp/widgets/expense_item.dart';


class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: dummyExpenses.length,
        itemBuilder: (context, index) {
          return ExpenseItem(expense: dummyExpenses[index]);
        },
      ),
    );
  }
}