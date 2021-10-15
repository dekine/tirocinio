import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key, required this.addTx}) : super(key: key);

  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount == null ||
        _selectedDate == null ||
        enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
                // onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: amountController,
                onSubmitted: (_) => _submitData(),
              ),
              Platform.isAndroid
                  ? SizedBox(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _selectedDate == null
                                  ? 'No Date Chosen'
                                  : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                            ),
                          ),
                          TextButton(
                            child: const Text('Choose date'),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(15.0),
                              primary: Theme.of(context).colorScheme.primary,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: _presentDatePicker,
                          ),
                        ],
                      ))
                  : SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          onDateTimeChanged: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          }),
                    ),
              Platform.isAndroid
                  ? ElevatedButton(
                      child: const Text('Add transaction'),
                      onPressed: _submitData,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                        primary: Theme.of(context).colorScheme.primary,
                        textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16),
                      ),
                    )
                  : CupertinoButton(
                      child: const Text('Add transaction'),
                      onPressed: _submitData),
            ],
          ),
        ),
      ),
    );
  }
}
