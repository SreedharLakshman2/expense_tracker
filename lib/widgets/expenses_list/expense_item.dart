import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem({super.key, required this.expense});

  final Expense expense;

  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
