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
      child: listTxs.isEmpty
          ? Column(
              children: [
                Text(
                  'No Tx yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              //how many times will the process be done
              itemCount: listTxs.length,
              //what's going to be printent onto the screen
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 9, horizontal: 7),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: FittedBox(
                          child: Text('\$${listTxs[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      listTxs[index].name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle:
                        Text(DateFormat.yMMM().format(listTxs[index].date)),
                  ),
                );
              },
              //map to paint n widgets,
            ),
    );
  }
}

/*

 return Card(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        padding: EdgeInsets.all(12),
                        child: Text(
                          '\$ ${listTxs[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listTxs[index].name,
                            style: Theme.of(context).textTheme.headline6,
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

 */