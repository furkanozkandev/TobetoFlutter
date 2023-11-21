import 'package:flutter/material.dart';
import 'package:myexpenseapp/models/expense.dart';
import 'package:intl/intl.dart';


class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        title: Text(
          expense.name,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
        ),
        subtitle: Text("${expense.price} ₺"),
        trailing: Text(
          DateFormat('dd.MM.yyyy').format(expense.date),
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(categoryIcons[expense.category], color: Colors.white),
        ),
      ),
    );
  }
}