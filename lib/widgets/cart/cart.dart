import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/cart/cart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Cart extends StatelessWidget {
  Cart({super.key, required this.expenses});

  List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.shopping),
      ExpenseBucket.forCategory(expenses, Category.holiday),
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.others),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpense > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpense;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.0),
            Theme.of(context).primaryColor.withOpacity(0.3),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var bucket in buckets)
                  CartBar(
                    expense: bucket.totalExpense == 0 ? 0 : bucket.totalExpense,
                    fill: bucket.totalExpense == 0
                        ? 0
                        : bucket.totalExpense / maxTotalExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: buckets
                .map(
                  (iconBuck) => Expanded(
                    child: Icon(
                      iconCategory[iconBuck.category],
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 5),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: bucket.totalExpense == 0
                        ? const Text("")
                        : Text(
                            NumberFormat.currency(
                                    locale: 'id', symbol: '', decimalDigits: 0)
                                .format(bucket.totalExpense),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
