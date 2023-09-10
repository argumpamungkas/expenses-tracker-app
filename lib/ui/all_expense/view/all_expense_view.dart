import 'package:flutter/material.dart';

class AllExpenseView extends StatelessWidget {
  const AllExpenseView({super.key});

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
    );
  }
}
