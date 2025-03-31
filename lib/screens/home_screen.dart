import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/mocks/expenses_mock.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:flutter_expense_tracker/widgets/forms/expense_form.dart';
import 'package:flutter_expense_tracker/widgets/lists/expenses_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _registeredExpenses = [...expensesMock];

  Future<void> _openAddExpenseOverlay() async {
    final expenseToBeAdded = await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => ExpenseForm(),
    );

    _addExpenseToRegisteredList(expenseToBeAdded);
  }

  void _addExpenseToRegisteredList(Expense? expense) {
    if (expense == null) return;

    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('Charts'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
