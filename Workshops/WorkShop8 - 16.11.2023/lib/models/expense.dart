import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {  work, travel, food, dress  }

const categoryIcons = {
  Category.work: Icons.work,
  Category.travel: Icons.place_outlined,
  Category.dress: Icons.abc,
  Category.food: Icons.food_bank
};

class Expense {
  Expense(
      {required this.name, required this.price, required this.date, required this.category})
      : id = uuid.v4();
  final String id;
  final String name;
  final double price;
  final DateTime date;
  final Category category;
}