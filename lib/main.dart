import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/constants/themes/dark_theme.dart';
import 'package:flutter_expense_tracker/constants/themes/light_theme.dart';
import 'package:flutter_expense_tracker/screens/home_screen.dart';

void main() {
  runApp(const ExpensesTrackerApp());
}

class ExpensesTrackerApp extends StatelessWidget {
  const ExpensesTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kLightTheme,
      darkTheme: kDarkAppTheme,
      // themeMode: ThemeMode.system, // default
      home: const HomeScreen(),
    );
  }
}
