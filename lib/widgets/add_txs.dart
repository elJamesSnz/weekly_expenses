import 'package:flutter/material.dart';

class AddTxs extends StatefulWidget {
  final Function addNewTx;

  //se acepta
  AddTxs(this.addNewTx);

  @override
  State<AddTxs> createState() => _AddTxsState();
}

class _AddTxsState extends State<AddTxs> {
  final nameController = TextEditingController();

  final amountController = TextEditingController();

  void submit() {
    final inputName = nameController.text;
    final inputAmount = double.parse(amountController.text);

    if (inputName.isEmpty || inputAmount <= 0)
      return;
    else
      //widget. recovers the Function received from the class into the State class
      widget.addNewTx(nameController.text, double.parse(amountController.text));

    //Navigator's pop method to close the topmost screen displayed.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: nameController,
              onSubmitted: (_) => submit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submit(),
            ),
            FlatButton(
              onPressed: submit,
              child: Text('Add'),
              textColor: Colors.blueGrey,
            )
          ])),
    );
  }
}
