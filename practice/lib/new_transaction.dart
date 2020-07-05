import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTxHandler;

  NewTransaction(this.newTxHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  submitData() {
    if (amountController == null) return;

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.newTxHandler(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((_pickedDate) {
      if (_pickedDate == null)
        return;
      else
        setState(() {
          _selectedDate = _pickedDate;
        });
    });
  }

  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            onSubmitted: (_) => submitData(),
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  _selectedDate == null
                      ? 'No date chosen!'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                ),
              ),
              FlatButton(
                onPressed: pickDate,
                child: Text('Pick a date'),
                color: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: submitData,
          ),
        ],
      ),
    );
  }
}
