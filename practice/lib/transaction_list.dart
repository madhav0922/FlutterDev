import 'package:flutter/material.dart';

import './Model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  @override
  final List<Transaction> _transactionList;

  TransactionList(this._transactionList);

  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Text('${_transactionList[index].amount}'),
              ),
              title: Text('${_transactionList[index].title}'),
              subtitle: Text(
                DateFormat.yMMMd().format(_transactionList[index].date),
              ),
            ),
          );
        },
        itemCount: _transactionList.length,
      ),
    );
  }
}
