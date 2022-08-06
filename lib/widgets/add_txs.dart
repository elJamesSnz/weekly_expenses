import 'package:flutter/material.dart';

class AddTxs extends StatelessWidget {
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  final Function addNewTx;

  AddTxs(this.addNewTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              //onChanged: (value) {
              //nameInput = value;
              //},
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            FlatButton(
              onPressed: () {
                addNewTx(
                    nameController.text, double.parse(amountController.text));
              },
              child: Text('Add'),
              textColor: Colors.blueGrey,
            )
          ])),
    );
  }
}
