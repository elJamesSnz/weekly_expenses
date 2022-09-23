import 'package:flutter/material.dart';

import '../models/tx.dart';
import 'tx_item.dart';

class TxsList extends StatelessWidget {
  final List<Tx> listTxs;

  final Function deleteTx;

  TxsList(this.listTxs, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return listTxs.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    'No Tx yet',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        //listview has infinite height
        : ListView(
            children: [
              ...listTxs
                  .map((tx) => TxItem(
                        key: ValueKey(tx.id),
                        tx: tx,
                        deleteTx: deleteTx,
                      ))
                  .toList()
            ],
          );
  }
}
