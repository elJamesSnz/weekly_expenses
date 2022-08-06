//flutter imports
import 'package:flutter/material.dart';

//3rd party imports
import 'package:intl/intl.dart';
import 'package:weekly_expenses/widgets/user_txs.dart';

//my imports
import './widgets/user_txs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyExpenses',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  child: Text('GRÁFICO'),
                ),
              ),
              UserTxs(),
            ]),
      ),
    );
  }
}
