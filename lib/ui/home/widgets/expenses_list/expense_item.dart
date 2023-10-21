import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem({
    super.key,
    required this.expense,
    required this.onOpenModal,
    required this.onRemoveExpense,
  });

  Expense expense;
  void Function(Expense expense) onOpenModal;
  void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        onTap: () => onOpenModal(expense),
        leading: Icon(iconCategory[expense.category]),
        title: Text(
          expense.title,
        ),
        subtitle: Text(
          expense.formattedAmount,
        ),
        trailing: IconButton(
          onPressed: () => onRemoveExpense(expense),
          icon: const Icon(Icons.delete_outline_rounded),
        ),
        // Text(
        //   expense.formattedDate,
        // ),
      ),
    );
  }
}
