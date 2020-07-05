import 'package:flutter/material.dart';

import 'transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function deleteTx;

  TransactionList(this.transactionList, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 500,
    //   child: SingleChildScrollView()
    //  Single child scroll view is one method. however we can use a ListView in place of column that embedds SingleChildScrollView
    return Container(
      height: 300,
      child: transactionList.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                        // this wont work here if not enclosed with a container. ? why ? because the height (300) specified in the return container is not a direct parent of the image widget. and hence it wont inherit the property of parent but child.
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView(
              children: transactionList.map((tx) {
              return TransactionItem(
                  key: ValueKey(tx.id), transaction: tx, deleteTx: deleteTx);
            }).toList()),
      // ** replaced with ListTile widget
      // return Card(
      //   child: Row(
      //     children: [
      //       Container(
      //         margin: EdgeInsets.symmetric(
      //           horizontal: 15,
      //           vertical: 10,
      //         ),
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: Theme.of(context).primaryColor,
      //             width: 2,
      //           ),
      //         ),
      //         padding: EdgeInsets.all(10),
      //         child: Text(
      //           //earlier how we concatanated string and can also do in dart:  '\$' + tx.amount.toString(),
      //           // !! string interpolation in dart !!
      //           //'\$ ${tx.amount}',
      //           //string interpolated with $ combined as escape sequence. since, $ has a meaning for string interpolation in dart.

      //           '\$ ${transactionList[index].amount.toStringAsFixed(2)}',
      //           //toString used only to limit decimal places to 2 and round off. otherwise, not required.
      //           style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 20,
      //             color: Theme.of(context).primaryColor,
      //           ),
      //         ),
      //       ),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             transactionList[index].title,
      //             // style: TextStyle(
      //             //   fontWeight: FontWeight.bold,
      //             //   color: Theme.of(context).primaryColor,
      //             //   fontSize: 18,
      //             //),
      //             style: Theme.of(context).textTheme.title,
      //             //now managed via theme
      //           ),
      //           Text(
      //             DateFormat.yMMMd()
      //                 .format(transactionList[index].date),
      //             style: TextStyle(
      //               color: Colors.grey,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // );
      // },
      // itemCount: transactionList.length, // this was part of ListView.builder()
    );
  }
}
