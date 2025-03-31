import 'package:flutter_expense_tracker/enums/expense_category.dart';
import 'package:flutter_expense_tracker/models/expense.dart';

final List<Expense> expensesMock = [
  Expense(
    title: 'Lunch at Cafe',
    amount: 15.75,
    date: DateTime(2025, 3, 28),
    category: EExpenseCategory.food,
  ),
  Expense(
    title: 'Uber to work',
    amount: 12.50,
    date: DateTime(2025, 3, 29),
    category: EExpenseCategory.travel,
  ),
  Expense(
    title: 'Concert tickets',
    amount: 85.00,
    date: DateTime(2025, 3, 25),
    category: EExpenseCategory.leisure,
  ),
  Expense(
    title: 'Office supplies',
    amount: 32.99,
    date: DateTime(2025, 3, 27),
    category: EExpenseCategory.work,
  ),
  Expense(
    title: 'Groceries',
    amount: 67.40,
    date: DateTime(2025, 3, 26),
    category: EExpenseCategory.food,
  ),
  Expense(
    title: 'Weekend road trip fuel',
    amount: 45.20,
    date: DateTime(2025, 3, 22),
    category: EExpenseCategory.travel,
  ),
];
