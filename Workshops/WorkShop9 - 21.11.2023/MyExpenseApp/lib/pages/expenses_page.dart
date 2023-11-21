import 'dart:math';
import 'package:myexpenseapp/models/expense.dart';
import 'package:myexpenseapp/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage(this.expenses, this.onRemove, {Key? key})
      : super(key: key);
  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 150,
          child: Text(
            "Grafik Bölümü",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.expenses.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(widget.expenses[index]),
                child: ExpenseItem(widget.expenses[index]),
                onDismissed: (direction) {
                  // Silme işlemi gerçekleştildiğinde SnackBar'ı göster
                  final removedExpense = widget.expenses[index];
                  widget.onRemove(removedExpense);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Harcama Başarıyla Silindi', style: TextStyle(color : Colors.tealAccent, fontSize: 16) ),
                      backgroundColor: Colors.brown,
                      action: SnackBarAction(
                        label: 'Undo',
                        textColor: Colors.yellow,
                        onPressed: () {
                          // "Undo" butonuna tıklandığında silinen veriyi geri al
                          setState(() {
                            widget.expenses.insert(index, removedExpense);
                          });
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
