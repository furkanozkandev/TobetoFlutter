import 'package:myexpenseapp/models/expense.dart';

List<Expense> dummyExpenses = [
  Expense(name: "Yemek", price: 300, date: DateTime.now(), category: Category.food),
  Expense(name: "Seyahat", price: 1000, date: DateTime.now(), category: Category.travel),
  Expense(name: "Ofis Harcamaları", price: 1200, date: DateTime.now(), category: Category.work),
];