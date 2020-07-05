import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './Model/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var totalSum = 0.0;
      var weekDay = DateTime.now().subtract(Duration(days: index));
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          totalSum = recentTransactions[i].amount;
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        children: groupedTransactionValues.map(
          (data) {
            return Flexible(
              child: ChartBar(
                data['day'],
                data['amount'],
                (totalSpending == 0.0)
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
