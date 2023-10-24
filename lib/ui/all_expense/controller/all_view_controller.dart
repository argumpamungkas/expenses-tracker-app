import 'package:expense_tracker/db/repository.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:intl/intl.dart';

class AllViewController {
  Repository repo = Repository();

  List<Expense> listExpense = [];
  Set dateExpesne = {};
  Set dateMonth = {};

  Future<List<Expense>> getAllExpense() async {
    listExpense = await repo.getAllExpense("date", "asc");
    for (var dateExp in listExpense) {
      dateExpesne.add(dateExp.date);

      var month = DateFormat("MMMM").format(dateExp.date);
      dateMonth.add(month);
    }
    return listExpense;
  }
}
