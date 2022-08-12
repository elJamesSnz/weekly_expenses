//flutter imports
import 'package:flutter/material.dart';

//3rd party imports

//my imports
import './widgets/txs_list.dart';
import './widgets/add_txs.dart';
import './widgets/chart.dart';
import './models/tx.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyExpenses',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Tx> _listTxs = [
    //Tx(id: 'Tx1', name: 'Food', amount: 299.23, date: DateTime.now()),
    //Tx(id: 'Tx2', name: 'Videogame: MW2', amount: 129.99, date: DateTime.now()),
  ];

  List<Tx> get _recentTx {
    return _listTxs.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTx(String name, double amount) {
    final newTx = Tx(
        id: DateTime.now().toString(),
        name: name,
        amount: amount,
        date: DateTime.now());
    setState(() {
      //adding the element into the list
      _listTxs.add(newTx);
    });
  }

  void _modalNewTx(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          //to prevent the sheet from closing if you tap at the botom of the sheet
          onTap: () {},
          child: AddTxs(_addNewTx),
          //catch event and avoid tap
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        actions: [
          //list-of-widgets
          IconButton(
              onPressed: () => _modalNewTx(context), icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(_recentTx),
              TxsList(_listTxs),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _modalNewTx(context),
      ),
    );
  }
}
