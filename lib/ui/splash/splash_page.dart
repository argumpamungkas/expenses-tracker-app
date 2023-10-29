import 'package:expense_tracker/ui/home/view/expenses.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/splash_page";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, Expenses.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_note_sharp,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Text("Expense App"),
          ],
        ),
      ),
    );
  }
}
