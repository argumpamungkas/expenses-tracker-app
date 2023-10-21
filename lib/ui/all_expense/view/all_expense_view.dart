import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/ui/all_expense/controller/all_view_controller.dart';
import 'package:flutter/material.dart';

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
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _allViewController.dateExpesne.length,
                    itemBuilder: (context, index) {
                      var dateExp =
                          _allViewController.dateExpesne.elementAt(index);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 8,
                              bottom: 4,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              dateExp,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                              children:
                                  _allViewController.listExpense.map((expense) {
                            return expense.formattedDate == dateExp
                                ? Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    child: ListTile(
                                      leading:
                                          Icon(iconCategory[expense.category]),
                                      title: Text(expense.title),
                                      subtitle: Text(expense.formattedAmount),
                                    ),
                                  )
                                : Container();
                          }).toList()),
                        ],
                      );
                    },
                  );
          },
        ));
  }
}
