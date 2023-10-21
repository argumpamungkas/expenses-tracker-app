import 'package:flutter/material.dart';

class DetailMonthExpenseView extends StatelessWidget {
  const DetailMonthExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Month"),
        centerTitle: true,
      ),
      body: Container(
        height: 100,
        width: 100,
        color: Colors.amber,
        child: const Text("Month"),
      ),
    );
  }
}
