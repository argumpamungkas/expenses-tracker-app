import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

DateFormat formatter = DateFormat.yMd();

NumberFormat idrFormat = NumberFormat.currency(locale: 'id', symbol: "Rp ");

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const iconCategory = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  String id;
  String title;
  int amount;
  DateTime date;
  Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedAmount => idrFormat.format(amount);

  String get formattedDate => formatter.format(date);
}

class ExpenseBucket {
  List<Expense> listExpenses;
  Category category;

  ExpenseBucket({
    required this.listExpenses,
    required this.category,
  });

// Mendapatkan object expenses berdasarkan Category tertentu (filtering)
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : listExpenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  // Mendapatkan semua pengeluaran
  double get totalExpense {
    double sum = 0;

    for (final expense in listExpenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
