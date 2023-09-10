import 'package:expense_tracker/util/util.dart';
import 'package:flutter/material.dart';

enum Category { food, shopping, holiday, work, others }

const iconCategory = {
  Category.food: Icons.food_bank_rounded,
  Category.shopping: Icons.shopify,
  Category.holiday: Icons.tag_faces_rounded,
  Category.work: Icons.work,
  Category.others: Icons.apps,
};

class Expense {
  String? id;
  String title;
  int amount;
  DateTime date;
  Category category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  factory Expense.fromMap(Map<String, dynamic> map) {
    Category category;

    if (map['category'] == 'food') {
      category = Category.food;
    } else if (map['category'] == 'shopping') {
      category = Category.shopping;
    } else if (map['category'] == 'holiday') {
      category = Category.holiday;
    } else if (map['category'] == 'work') {
      category = Category.work;
    } else {
      category = Category.others;
    }
    return Expense(
      id: map['uuid'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: category,
    );
  }

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
