import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/mocks/expenses_mock.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:flutter_expense_tracker/widgets/charts/chart.dart';
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
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(maxHeight: double.infinity),
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

  void _removeExpenseFromRegisteredList(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    _handleSnackBarOnRemoveExpense(expense, index: expenseIndex);
  }

  void _handleSnackBarOnRemoveExpense(Expense expense, {required int index}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense deleted!'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () => _undoExpenseDeletion(expense, index: index),
        ),
      ),
    );
  }

  void _undoExpenseDeletion(Expense expense, {required int index}) {
    final expenseInList = _registeredExpenses.contains(expense);
    if (expenseInList) return;

    setState(() {
      _registeredExpenses.insert(index, expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(child: Text('No expenses found.'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpenseFromRegisteredList,
      );
    }

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
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
              : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent),
                ],
              ),
    );
  }
}
