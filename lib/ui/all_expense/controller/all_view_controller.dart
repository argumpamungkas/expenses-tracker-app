import 'package:expense_tracker/db/repository.dart';
import 'package:expense_tracker/models/expense.dart';

class AllViewController {
  Repository repo = Repository();

  List<Expense> listExpense = [];
  Set dateExpesne = {};

  Future<List<Expense>> getAllExpense() async {
    listExpense = await repo.getAllExpense("date", "asc");
    for (var dateExp in listExpense) {
      dateExpesne.add(dateExp.formattedDate);
    }
    return listExpense;
  }
}
