import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/tx.dart';

class TxsList extends StatelessWidget {
  final List<Tx> listTxs;

  TxsList(this.listTxs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        //how many times will the process be done
        itemCount: listTxs.length,
        //what's going to be printent onto the screen
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 2)),
                  padding: EdgeInsets.all(12),
                  child: Text(
                    '\$ ${listTxs[index].amount}',
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
                      listTxs[index].name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      DateFormat.yMMMd().format(listTxs[index].date),
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          );
        },
        //map to paint n widgets,
      ),
    );
  }
}

/*
children: listTxs.map((tx) {
          return Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 2)),
                  padding: EdgeInsets.all(12),
                  child: Text(
                    '\$ ${tx.amount}',
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      DateFormat.yMMMd().format(tx.date),
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          );
        }).toList()
*/
