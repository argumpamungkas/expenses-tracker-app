import 'package:expense_tracker/util/util.dart';
import 'package:flutter/material.dart';

class InfoExpenses extends StatelessWidget {
  InfoExpenses({super.key, required this.totalExpense});

  int totalExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              text: "Today, You are expense ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              children: [
                TextSpan(
                  text: "${idrFormat.format(totalExpense)}.",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
