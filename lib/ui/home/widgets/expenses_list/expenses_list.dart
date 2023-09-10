import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/ui/home/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList(
      {super.key,
      required this.expenses,
      required this.onRemoveExpense,
      required this.onUpdateExpense});

  final List<Expense> expenses;
  void Function(Expense expense) onRemoveExpense;
  void Function(Expense expense) onUpdateExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpenseItem(
        expense: expenses[index],
        onOpenModal: onUpdateExpense,
        onRemoveExpense: onRemoveExpense,
      ),
    );
  }
}
