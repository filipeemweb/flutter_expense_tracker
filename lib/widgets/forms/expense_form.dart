import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/enums/expense_category.dart';
import 'package:flutter_expense_tracker/models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  EExpenseCategory _selectedCategory = EExpenseCategory.leisure;
  DateTime? _selectedDate;

  String get _datetimeInputValue =>
      _selectedDate == null
          ? 'No date selected'
          : formatter.format(_selectedDate!);

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  List<DropdownMenuItem<EExpenseCategory>> _mapCategoriesToDropdownItems() {
    return EExpenseCategory.values.map((category) {
      return DropdownMenuItem(
        value: category,
        child: Text(category.name.toUpperCase()),
      );
    }).toList();
  }

  void _handleCategorySelected(EExpenseCategory? category) {
    if (category == null) return;

    setState(() {
      _selectedCategory = category;
    });
  }

  void _submitExpenseData() {
    if (!_isFormValid) return _openPlatformErrorDialog();

    final enteredAmount = double.tryParse(_amountController.text) ?? 0.0;

    final expense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );

    Navigator.of(context).pop(expense);
  }

  void _openPlatformErrorDialog() {
    if (Platform.isIOS) {
      _renderCupertinoErrorDialog();
      return;
    }

    _renderDefaultErrorDialog();
  }

  void _renderDefaultErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid value was entered for each field.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Understood'),
            ),
          ],
        );
      },
    );
  }

  void _renderCupertinoErrorDialog() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid value was entered for each field.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Understood'),
            ),
          ],
        );
      },
    );
  }

  bool get _isFormValid {
    return _isTitleValid && _isAmountValid && _isDateValid;
  }

  bool get _isTitleValid {
    final trimmedTitle = _titleController.text.trim();
    return trimmedTitle.length > 3;
  }

  bool get _isAmountValid {
    final parsedAmount = double.tryParse(_amountController.text);
    return parsedAmount != null && parsedAmount > 0;
  }

  bool get _isDateValid {
    return _selectedDate != null;
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constrains) {
        final width = constrains.maxWidth;

        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child:
                  width >= 600
                      ? Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildTitleInput()),
                              const SizedBox(width: 16),
                              Expanded(child: _buildAmountInput()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(child: _buildDatePicker()),
                              const SizedBox(width: 16),
                              Expanded(child: _buildDropdown()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [_buildFormButtons()],
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          _buildTitleInput(),
                          Row(
                            children: [
                              Expanded(child: _buildAmountInput()),
                              SizedBox(width: 16),
                              Expanded(child: _buildDatePicker()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(child: _buildDropdown()),
                              const SizedBox(width: 24),
                              _buildFormButtons(),
                            ],
                          ),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleInput() => TextField(
    controller: _titleController,
    maxLength: 50,
    decoration: const InputDecoration(labelText: 'Title'),
  );

  Widget _buildAmountInput() => TextField(
    controller: _amountController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(prefixText: '\$', labelText: 'Amount'),
  );

  Widget _buildDatePicker() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(child: Text(_datetimeInputValue)),
      IconButton(
        onPressed: () => _openDatePicker(),
        icon: Icon(Icons.calendar_month),
      ),
    ],
  );

  Widget _buildDropdown() => DropdownButton<EExpenseCategory>(
    value: _selectedCategory,
    items: _mapCategoriesToDropdownItems(),
    onChanged: _handleCategorySelected,
  );

  Widget _buildFormButtons() => Row(
    children: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: _submitExpenseData,
        child: const Text('Save expense'),
      ),
    ],
  );
}
