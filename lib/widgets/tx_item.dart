import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/tx.dart';

class TxItem extends StatefulWidget {
  const TxItem({
    Key? key,
    required this.tx,
    required this.deleteTx,
  }) : super(key: key);

  final Tx tx;
  final Function deleteTx;

  @override
  State<TxItem> createState() => _TxItemState();
}

class _TxItemState extends State<TxItem> {
  Color? _randBgColor;

  @override
  void initState() {
    const avColors = [Colors.red, Colors.amber, Colors.purple, Colors.blue];
    _randBgColor = avColors[Random().nextInt(4)];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 9, horizontal: 7),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _randBgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: FittedBox(
              child: Text('\$${widget.tx.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.tx.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMM().format(widget.tx.date)),
        trailing: MediaQuery.of(context).size.width > 450
            ? FlatButton.icon(
                onPressed: () => widget.deleteTx(widget.tx.id),
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                label: Text('del'))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                //since is requieres an argument it is wrap in an anonym funct
                onPressed: () => widget.deleteTx(widget.tx.id),
              ),
      ),
    );
  }
}
