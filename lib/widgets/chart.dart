import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/tx.dart';

class Chart extends StatelessWidget {
  final List<Tx> recentTxs;
  Chart(this.recentTxs);

  List<Map<String, Object>> get groupedTxs {
    //generate a new list
    return List.generate(7, (index) {
      //second element to generate
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      //the recentTxs ant index i is verified
      for (int i = 0; i < recentTxs.length; i++) {
        if (recentTxs[i].date.day == weekDay.day &&
            recentTxs[i].date.month == weekDay.month &&
            recentTxs[i].date.year == weekDay.year) {
          totalSum += recentTxs[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxAmountSpent {
    //fold change a list to another type according to the function passed as agm
    //receives prev value and the value to interact with
    return groupedTxs.fold(0.0, (sum, item) {
      double amount = item['amount'] as double;
      return sum + amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTxs);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      //if we want to add a Container to add padding
      //it is possible to use the Padding widget
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTxs.map((data) {
            return Flexible(
                //flexfit value: loose, tight
                //flex, distribute more space for a child
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'] as String,
                    data['amount'] as double,
                    maxAmountSpent == 0.0
                        ? 0.0
                        : (data['amount'] as double) / maxAmountSpent));
          }).toList(),
        ),
      ),
    );
  }
}
