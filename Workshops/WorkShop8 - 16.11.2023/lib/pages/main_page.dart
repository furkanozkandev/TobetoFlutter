import 'package:myexpenseapp/pages/expenses_page.dart';
import 'package:myexpenseapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _updateExpenses() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Expense App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_sharp, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return NewExpense(onExpenseAdded: _updateExpenses);
                },
              );
            },
          ),
        ],
      ),
      body: ExpensesPage(),
    );
  }
}