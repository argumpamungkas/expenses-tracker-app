import 'package:expense_tracker/ui/all_expense/view/all_expense_view.dart';
import 'package:expense_tracker/ui/home/view/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF0C356A));
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF183D3D),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
        ),
        listTileTheme: const ListTileThemeData().copyWith(
          iconColor: kColorScheme.primary,
          tileColor: kColorScheme.secondaryContainer,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kColorScheme.primary,
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 12,
            color: kColorScheme.primary,
          ),
          leadingAndTrailingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: kColorScheme.primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: kColorScheme.onPrimaryContainer,
              ),
            ),
      ),
      themeMode: ThemeMode.light,
      initialRoute: "/",
      routes: {
        "/": (context) => const Expenses(),
        "/all_expense": (context) => AllExpenseView(),
      },
    );
  }
}
