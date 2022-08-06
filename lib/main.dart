import 'package:flutter/material.dart';
import './tx.dart';

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
  final List<Tx> Txs = [
    Tx(id: 'Tx1', name: 'Food', amount: 299.23, date: DateTime.now()),
    Tx(
        id: 'Tx2',
        name: 'Videogame: MW2',
        amount: 1199.99,
        date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('GRÁFICO'),
              ),
            ),
            Column(
              //map to paint n widgets,
              children: Txs.map((tx) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueGrey, width: 2)),
                        padding: EdgeInsets.all(12),
                        child: Text(
                          tx.amount.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blueGrey),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            tx.date.toString(),
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            )
          ]),
    );
  }
}
