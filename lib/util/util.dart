import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

DateFormat formatter = DateFormat('dd/MM/yyyy');

NumberFormat idrFormat =
    NumberFormat.currency(locale: 'id', symbol: "Rp ", decimalDigits: 0);
String formatNumber(String s) =>
    NumberFormat.decimalPattern('id').format(int.parse(s));

const uuid = Uuid();

showDialogLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Loading..."),
          ],
        ),
      );
    },
  );
}
