import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem({super.key, required this.expense});

  Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: ListTile(
        leading: Icon(iconCategory[expense.category]),
        title: Text(
          expense.title,
        ),
        subtitle: Text(
          expense.formattedAmount,
        ),
        trailing: Text(
          expense.formattedDate,
        ),
      ),
    );
  }
}
