import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // import services.dart
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        //errorColor: Colors.red,   // not required since default colour for error is also red
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Opensans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                // This provides text styling on appbar for all activities(widgets) throughout the app rather than adding style to each manually.
              ),
        ),
      ),
      home: Expense(),
    );
  }
}

class Expense extends StatefulWidget {
  // final String title;
  // final String amount;   // method 1
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'New gear',
    //   amount: 15.55,
    //   date: DateTime.now(),
    // ),   //emptied to display image when no transactions are present
  ];

  bool _showChart = false;

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    var newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    // since it starts adding of a new transaction.
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          // builder also takes a context but we dont care to store it here, hence _ is used.
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(
      () => _userTransactions.removeWhere((tx) => tx.id == id),
    );
  }

  // Getter to get recent transaction of last 7 days out of all transactions
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      // this function returns true if it happens within the last week else false
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList(); // called to silence iterable error, as without this an iterable is returned and not a list. Returntype demanded however is list.
  }

  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Calculator'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  //  using a cupertino button here rendered the button out of axis and small
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Expense Calculator'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, Widget _txList, PreferredSizeWidget appBar) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart: ',
            style: Theme.of(context)
                .textTheme
                .headline6, // Otherwise could have used CupertinoApp just like MaterialApp with Platform condition and its own CupertinoTheme but not required since it is very limited for themeing and our app is smol. :3
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : _txList,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, Widget _txList, PreferredSizeWidget appBar) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      _txList,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar();

    final _txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height - // App bar height
              mediaQuery.padding.top) * // Status bar height
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final _adaptiveBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container(
            //   width: double.infinity,
            //   child: Card(
            //     elevation: 5, // drop shadow for card
            //     child: Text('Card1'),
            //     // this card inherits parent Container properties.
            //     // A card inherits its child's properties, until a parent is present.
            //     // If a parent is present then ofc parent properties are inherited.
            //     // In this case no parent is present therefore this card inherits child's properties.
            //   ),
            // ),

            // ** NOW CARRYING ON WITH CHART **
            if (_isLandscape)
              ..._buildLandscapeContent(mediaQuery, _txListWidget, appBar),

            if (!_isLandscape)
              ..._buildPortraitContent(mediaQuery, _txListWidget, appBar),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _adaptiveBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: _adaptiveBody,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          );
  }
}
