import 'package:expense_tracker/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';
import './models/expense.dart';
import 'widgets/expenses_list/expense_list.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});
  //final Expense newExpense;

  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> registeredExpense = [
    Expense(
        title: 'Flutter Course',
        amount: 100.00,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 100.00,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: newExpenseAdded,
      ),
    );
  }

  void newExpenseAdded(Expense newExpense, String welcomeString) {
    setState(() {
      registeredExpense.add(newExpense);
      print(welcomeString);
    });
  }

  void removeExpense(Expense expense) {
    var expenseIndex = registeredExpense.indexOf(expense);
    setState(() {
      registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense deleted'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredExpense.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  Widget build(context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: registeredExpense,
        onRemove: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Flutter Expenses Tracker'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
