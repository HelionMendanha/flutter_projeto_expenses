import 'package:expenses/components/chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpenseApp());

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Tenis 1',
      date: DateTime.now(),
      value: 10.99,
    ),
    Transaction(
      id: 't2',
      title: 'Tenis 2',
      date: DateTime.now(),
      value: 212.99,
    ),
    Transaction(
      id: 't3',
      title: 'Tenis 3',
      date: DateTime.now(),
      value: 310.99,
    ),
    Transaction(
      id: 't4',
      title: 'Tenis 4',
      date: DateTime.now(),
      value: 410.99,
    ),
    Transaction(
      id: 't5',
      title: 'Tenis 5',
      date: DateTime.now().subtract(Duration(days: 1)),
      value: 10.99,
    ),
    Transaction(
      id: 't6',
      title: 'Tenis 6',
      date: DateTime.now().subtract(Duration(days: 2)),
      value: 660.99,
    ),
    Transaction(
      id: 't7',
      title: 'Tenis 877',
      date: DateTime.now().subtract(Duration(days: 3)),
      value: 721.99,
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime data) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: data,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
            color: Colors.red,
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
          color: Colors.red,
        ),
      ],
    );

    final availableHeigth = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return new Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('Exibir Gráfico'),
              //     Switch(
              //       value: _showChart,
              //       onChanged: (value) {
              //         setState(() {
              //           _showChart = value;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              if (_showChart || !isLandscape)
                Container(
                  height: availableHeigth * (isLandscape ? 0.7 : 0.30),
                  child: Chart(_recentTransactions),
                ),
            if (!_showChart || !isLandscape)
              Container(
                height: availableHeigth * 0.70,
                child: TransactionList(_transactions, _deleteTransaction),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
