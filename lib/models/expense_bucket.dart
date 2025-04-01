import 'package:flutter_expense_tracker/enums/expense_category.dart';
import 'package:flutter_expense_tracker/models/expense.dart';

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, {required this.category})
    : expenses =
          allExpenses.where((expense) => expense.category == category).toList();

  final EExpenseCategory category;
  final List<Expense> expenses;

  // double get totalExpenses {
  //   double sum = 0.0;
  //   for (final expense in expenses) {
  //     sum += expense.amount;
  //   }
  //   return sum;
  // }

  double get totalExpenses =>
      expenses.fold(0.0, (sum, expense) => sum + expense.amount);
}
