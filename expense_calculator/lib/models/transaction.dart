import 'package:flutter/foundation.dart';
// for @required. We can also use material.dart but foundation.dart is the end of file that invokes @required.

class Transaction {
  // normal class just to "model" how a transaction looks and what are its parameters.
  // Hence, no need for a widget based class.
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
