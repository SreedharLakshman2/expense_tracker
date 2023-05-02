import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemove});

  final List<Expense> expenses;

  final Function(Expense expense) onRemove;

  Widget build(context) {
// If we have unknown length of item we have to go with List insted of column().
// builder(itemBuilder:) will create row/cell of data, If the items are visible or about to visible inside list.
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctxt, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemove(expenses[index]);
        },
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
