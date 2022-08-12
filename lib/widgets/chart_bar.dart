import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String labelTxt;
  final double spentAmount;
  final double spentPct;

  //constructor w/ named arguments
  ChartBar(this.labelTxt, this.spentAmount, this.spentPct);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${spentAmount.toStringAsFixed(0)}'),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              //values from 0 to 1 where 1 is 100% of container value
              FractionallySizedBox(
                heightFactor: spentPct,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(labelTxt),
      ],
    );
  }
}
