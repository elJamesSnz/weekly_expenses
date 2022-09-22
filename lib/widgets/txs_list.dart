import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/tx.dart';

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
                  subtitle: Text(DateFormat.yMMM().format(listTxs[index].date)),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(listTxs[index].id),
                          icon: Icon(Icons.delete),
                          textColor: Theme.of(context).errorColor,
                          label: Text('del'))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          //since is requieres an argument it is wrap in an anonym funct
                          onPressed: () => deleteTx(listTxs[index].id),
                        ),
                ),
              );
            },
            //map to paint n widgets,
          );
  }
}
