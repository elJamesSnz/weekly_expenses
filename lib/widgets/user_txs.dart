import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import './add_txs.dart';
import './txs_list.dart';
import '../models/tx.dart';

class UserTxs extends StatefulWidget {
  const UserTxs({Key? key}) : super(key: key);

  @override
  State<UserTxs> createState() => _UserTxsState();
}

class _UserTxsState extends State<UserTxs> {
  final List<Tx> _listTxs = [
    Tx(id: 'Tx1', name: 'Food', amount: 299.23, date: DateTime.now()),
    Tx(id: 'Tx2', name: 'Videogame: MW2', amount: 129.99, date: DateTime.now()),
  ];

  void _addNewTx(String name, double amount) {
    print('new attempt');
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [AddTxs(_addNewTx), TxsList(_listTxs)],
    );
  }
}
