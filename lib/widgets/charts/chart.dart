import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/constants/category_icons.dart';
import 'package:flutter_expense_tracker/enums/expense_category.dart';
import 'package:flutter_expense_tracker/models/expense.dart';
import 'package:flutter_expense_tracker/models/expense_bucket.dart';
import 'package:flutter_expense_tracker/widgets/charts/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, category: EExpenseCategory.food),
      ExpenseBucket.forCategory(expenses, category: EExpenseCategory.leisure),
      ExpenseBucket.forCategory(expenses, category: EExpenseCategory.travel),
      ExpenseBucket.forCategory(expenses, category: EExpenseCategory.work),
    ];
  }

  double get maxTotalExpense => buckets.fold<double>(
    0,
    (previousValue, bucket) => max(previousValue, bucket.totalExpenses),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.3),
            theme.colorScheme.primary.withValues(alpha: 0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill:
                        bucket.totalExpenses > 0
                            ? bucket.totalExpenses / maxTotalExpense
                            : 0,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ...buckets.map((bucket) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      categoryIcons[bucket.category],
                      color:
                          isDarkMode
                              ? theme.colorScheme.secondary
                              : theme.colorScheme.primary.withValues(
                                alpha: 0.7,
                              ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
