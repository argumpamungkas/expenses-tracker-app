import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/ui/all_expense/controller/all_view_controller.dart';
import 'package:expense_tracker/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllExpenseView extends StatelessWidget {
  AllExpenseView({super.key});

  final AllViewController _allViewController = AllViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Expense"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text("DELETE ALL"),
            ),
          ],
        ),
        body: FutureBuilder(
          future: _allViewController.getAllExpense(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No data expense"),
              );
            }

            return _allViewController.listExpense.isEmpty
                ? const Center(
                    child: Text("No data expense"),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: GridView.builder(
                      itemCount: _allViewController.dateMonth.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        childAspectRatio: 1.5 / 1,
                      ),
                      itemBuilder: (context, index) {
                        var month =
                            _allViewController.dateMonth.elementAt(index);

                        var total = 0;
                        for (var exp in _allViewController.listExpense) {
                          var dateExp = DateFormat("MMMM").format(exp.date);
                          if (dateExp == month) {
                            total += exp.amount;
                          }
                        }
                        return InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, "/detail_expense"),
                          borderRadius: BorderRadius.circular(16),
                          splashColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          highlightColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                  width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$month",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  idrFormat.format(total),
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
          },
        ));
  }
}
