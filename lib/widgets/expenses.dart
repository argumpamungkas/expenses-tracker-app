import 'package:expense_tracker/widgets/info_expenses.dart';
import 'package:expense_tracker/widgets/cart/cart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/modal_sheet.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _listExpenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      _listExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final indexExpense = _listExpenses.indexOf(expense);
    setState(() {
      _listExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text("Deleted ${expense.title}"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _listExpenses.insert(indexExpense, expense);
            });
          },
        ),
      ),
    );
  }

  void _removeAllExpense() {
    final undExpese = List.of(_listExpenses);
    setState(() {
      _listExpenses.removeRange(0, _listExpenses.length);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Deleted All"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _listExpenses.insertAll(0, undExpese);
            });
          },
        ),
      ),
    );
  }

  void _openExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => ModalSheet(onAddExpense: _addExpense),
    );
  }

  int get _getTotalExpense {
    int total = 0;

    for (final expense in _listExpenses) {
      total += expense.amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text("No Data Expense"));

    if (_listExpenses.isNotEmpty) {
      mainContent = Column(
        children: [
          InfoExpenses(totalExpense: _getTotalExpense),
          Cart(expenses: _listExpenses),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: _removeAllExpense,
              child: const Text("Delete All"),
            ),
          ),
          Expanded(
            child: ExpensesList(
              expenses: _listExpenses,
              onRemoveExpense: _removeExpense,
            ),
          ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses App"),
        actions: [
          IconButton(
            onPressed: _openExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: mainContent,
    );
  }
}
