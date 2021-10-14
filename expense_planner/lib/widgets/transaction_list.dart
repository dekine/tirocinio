import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 250,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover)),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  shadowColor: Theme.of(context).colorScheme.primaryVariant,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: Theme.of(context).textTheme.headline6),
                    subtitle: Text(
                        DateFormat.yMd()
                            .add_Hm()
                            .format(transactions[index].date),
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
