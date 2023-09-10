import 'package:expense_tracker/db/repository.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesController {
  Repository repoDb = Repository();

  List<Expense> listExpenses = [];

  void addExpense(Expense expense) async {
    await repoDb.addExpense(expense);
    getAllExpense();
  }

  Future<List<Expense>> getAllExpense() async {
    listExpenses = await repoDb.getAllExpense();
    return listExpenses;
  }

  void updateExpense(Expense expense) async {
    await repoDb.updateExpense(expense);
    getAllExpense();
  }

  void deleteExpense(Expense expense) async {
    await repoDb.deleteExpense(expense);
    getAllExpense();
  }

  void deleteAllExpense() async {
    await repoDb.deleteAllExpense();
    getAllExpense();
  }

  int get getTotalExpense {
    int total = 0;

    for (final expense in listExpenses) {
      total += expense.amount;
    }
    return total;
  }
}
