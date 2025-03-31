import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/mocks/expenses_mock.dart';
import 'package:flutter_expense_tracker/widgets/expenses_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Page')),
      body: Column(
        children: [
          const Text('Charts'),
          Expanded(child: ExpensesList(expenses: expensesMock)),
        ],
      ),
    );
  }
}
