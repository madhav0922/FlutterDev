import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function newTxHandler;

  NewTransaction(this.newTxHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController == null) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;
    widget.newTxHandler(
      // this 'widget.' class is what helps the text added into the fields not disappear when done is clicked.
      //  automatically got generated when converted newtransaction from stateless to stateful
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
    // context created automatically as we extend state class.
    // This pops the top most item on stack. the stack is a stack of activities and the top most activity is modal sheet.
    // The modal sheet is hence, now closed automatically after pressing done to add values into list by adding this line.
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((_pickedDate) {
      //future is utilized by using .then
      // this wont wait and lock for it to complete however, will proceed with other instructions and, update the result asap.
      if (_pickedDate == null)
        return;
      else {
        setState(() {
          _selectedDate = _pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10), // To scroll up the modal sheet for small devices to see textfield while entering
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                //onChanged: (val) => title = val,
                // method 1 but this is hard on flutter because vars arent final. This can be done in " stateless widget ".
                // Whats the error? if made final then we will have to initialize them with null or some string and after that they wont be changed on RUNTIME. since they are final.
                // method 2. also good for stateless widget as it produces no error and vars can be made final.
                controller: _titleController,
                onSubmitted: (_) =>
                    _submitData(), // (_) is method of dumping the argument recieved as it is not needed.
                //however, other approach would have been to make function definition as..
                // _submitData(String data) // but with that we will have to pass a 'DUMMY' string as argument when submitted via a button or something.
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                //onChanged: (val) => amount = val, // method 1
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
                // for ios as the android one, might not let add decimals
                //TextInputType.number, // for android
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton(
                      'Choose Date',
                      _selectDate,
                    ), //custom made button widget that is adaptive
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
                // parse string as a double. toDouble or to String() not used because we are sending(parsing).
                // This will break if a number is not added in the field.
                // eg: hello cannot be converted to a number. '12' -> 12 can be converted.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
