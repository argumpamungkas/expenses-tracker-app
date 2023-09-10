import 'package:flutter/material.dart';

class ShowDialogDelete extends StatelessWidget {
  ShowDialogDelete({super.key, required this.removeAllExpense});

  void Function() removeAllExpense;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text("Are you sure Delete All expense for today?"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              TextButton(
                onPressed: removeAllExpense,
                child: const Text("Yes"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
