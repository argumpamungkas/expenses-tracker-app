import 'package:expense_tracker/db/database_manager.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseManager dbManager = DatabaseManager.instance;

  Future<void> addExpense(Expense expense) async {
    Database db = await dbManager.db;

    await db.insert(
      "expenses",
      {
        "uuid": expense.id,
        "title": expense.title,
        "amount": expense.amount,
        "date": expense.date.toIso8601String(),
        "category": expense.category.name,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Expense>> getAllExpense() async {
    Database db = await dbManager.db;

    List allExpense = await db.query("expenses", orderBy: "id DESC");
    if (allExpense.isEmpty) {
      return [];
    } else {
      return allExpense.map((e) => Expense.fromMap(e)).toList();
    }
  }

  Future<void> updateExpense(Expense expense) async {
    Database db = await dbManager.db;

    await db.update(
      "expenses",
      {
        "title": expense.title,
        "amount": expense.amount,
        "date": expense.date.toIso8601String(),
        "category": expense.category.name,
      },
      where: "uuid = ?",
      whereArgs: [expense.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteExpense(Expense expense) async {
    Database db = await dbManager.db;

    await db.delete("expenses", where: "uuid = ?", whereArgs: [expense.id]);
  }

  Future<void> deleteAllExpense() async {
    Database db = await dbManager.db;

    await db.delete("expenses");
  }
}
