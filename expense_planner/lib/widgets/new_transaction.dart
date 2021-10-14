import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction({Key? key, required this.addTx}) : super(key: key);

  final Function addTx;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _submitData() {
    addTx(titleController.text, double.tryParse(amountController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) => _submitData,
            ),
            TextButton(
              child: const Text('Add transaction'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(15.0),
                primary: Colors.purple,
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
