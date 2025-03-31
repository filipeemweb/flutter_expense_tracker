import 'package:flutter_expense_tracker/enums/expense_category.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat('dd/MM/yyyy');

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final EExpenseCategory category;

  String get formattedDate => formatter.format(date);
}
