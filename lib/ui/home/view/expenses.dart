import 'package:expense_tracker/ui/all_expense/view/all_expense_view.dart';
import 'package:expense_tracker/ui/home/controller/expenses_controller.dart';
import 'package:expense_tracker/ui/home/widgets/info_expenses.dart';
import 'package:expense_tracker/ui/home/widgets/cart/cart.dart';
import 'package:expense_tracker/ui/home/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/ui/home/widgets/modal_sheet.dart';
import 'package:expense_tracker/ui/home/widgets/show_dialog_delete.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  static const routeName = "/expenses";

  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final ExpensesController _expensesController = ExpensesController();

  void _addExpense(Expense expense) {
    setState(() {
      _expensesController.addExpense(expense);
    });
  }

  void _updateExpense(Expense expense) {
    setState(() {
      _expensesController.updateExpense(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _expensesController.deleteExpense(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
        content: Text("Deleted ${expense.title} success"),
        // action: SnackBarAction(
        //   label: "Undo",
        //   onPressed: () {
        //     setState(() {
        //       _expensesController.addExpense(expense);
        //     });
        //   },
        // ),
      ),
    );
  }

  void _removeAllExpense() {
    // final undExpese = List.of(_expensesController.listExpenses);
    setState(() {
      _expensesController.deleteAllExpense();
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Success deleted all expense"),
        backgroundColor: Colors.green,
        // action: SnackBarAction(
        //   label: "Undo",
        //   textColor: Colors.white,
        //   onPressed: () {
        //     setState(() {
        //       _expensesController.listExpenses.insertAll(0, undExpese);
        //     });
        //   },
        // ),
      ),
    );
  }

  void _openExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      showDragHandle: true,
      useSafeArea: true,
      builder: (ctx) => ModalSheet(onAddExpense: _addExpense),
    );
  }

  void _openExpenseOverlayUpdate(Expense expense) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      showDragHandle: true,
      useSafeArea: true,
      builder: (ctx) => ModalSheet(
        onUpdateExpense: _updateExpense,
        expense: expense,
      ),
    );
  }

  void _showDialogDelete() {
    showDialog(
      context: context,
      builder: (context) => ShowDialogDelete(
        removeAllExpense: _removeAllExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses App"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pushNamed(context, AllExpenseView.routeName),
            child: const Text("VIEW ALL"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openExpenseOverlay,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Expense>>(
        future: _expensesController.getAllExpense(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading..."),
            );
          }

          if (!snapshot.hasData || _expensesController.listExpenses.isEmpty) {
            const Center(
              child: Text("No Data Expense"),
            );
          }

          return Column(
            children: [
              InfoExpenses(totalExpense: _expensesController.getTotalExpense),
              Cart(expenses: _expensesController.listExpenses),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 16, left: 16),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ElevatedButton(
                  onPressed: _showDialogDelete,
                  child: const Text("Delete All"),
                ),
              ),
              Expanded(
                child: ExpensesList(
                  expenses: _expensesController.listExpenses,
                  onRemoveExpense: _removeExpense,
                  onUpdateExpense: _openExpenseOverlayUpdate,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
