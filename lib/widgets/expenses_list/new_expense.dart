import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddExpense});

// Property, Which stores function as a value.
  void Function(Expense, String) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewExpenseState();
  }
}

class NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime.now();
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmt = double.tryParse(_amountController.text);
    final amounIsInValid = enteredAmt == null || enteredAmt <= 0;
    if (_titleController.text.trim().isEmpty ||
        amounIsInValid ||
        selectedDate == null) {
//Show error dialogue
      showDialog(
        context: context,
        builder: (cxt) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid, title, amount, and category was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(cxt);
                },
                child: Text('Close'))
          ],
        ),
      );
      return;
    } else {
      // Added expenses to list
      print('value adding');
      widget.onAddExpense(
          Expense(
              title: _titleController.text,
              amount: enteredAmt,
              date: selectedDate!,
              category: selectedCategory),
          'Nan vanthutean nu sollu');
      Navigator.pop(context);
      print('value added');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 50,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedDate == null
                        ? 'No date selected'
                        : formater.format(selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(
                          Icons.calendar_month,
                        ))
                  ],
                ),
              ),
            ],
          ),
          //DropDown, Cancel and Submit button actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      print(value);
                      selectedCategory = value;
                    });
                  }),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
