import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTxs extends StatefulWidget {
  final Function addNewTx;

  //se acepta
  AddTxs(this.addNewTx);

  @override
  State<AddTxs> createState() => _AddTxsState();
}

class _AddTxsState extends State<AddTxs> {
  final _nameController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _date;

  void _submit() {
    if (_amountController.text.isEmpty) {
      //to prevent parse error of non parsable null values
      return;
    }

    final inputName = _nameController.text;
    final inputAmount = double.parse(_amountController.text);

    if (inputName.isEmpty || inputAmount <= 0 || _date == null)
      return;
    else
      //widget. recovers the Function received from the class into the State class
      widget.addNewTx(inputName, inputAmount, _date);

    //Navigator's pop method to close the topmost screen displayed.
    Navigator.of(context).pop();
  }

  void _DatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((date) {
      //if user select cancel, date is null
      if (date == null) {
        return;
      } else {
        setState(() {
          _date = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: _nameController,
                onSubmitted: (_) => _submit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submit(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: _date == null
                          ? Text('No date selected')
                          : Text('Date: ${DateFormat.yMd().format(_date!)}'),
                    ),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _DatePicker,
                        child: Text(
                          'Choose date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submit,
                child: Text('Add'),
                textColor: Theme.of(context).textTheme.button!.color,
                color: Theme.of(context).primaryColor,
              )
            ])),
      ),
    );
  }
}
