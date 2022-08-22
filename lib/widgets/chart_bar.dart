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
    //layoutbuilder w constriants in order to dynamically know height
    //and width avialble within a custom widget

    return LayoutBuilder(builder: ((context, constraints) {
      return Column(
        children: [
          //FittedBox forces its child in available space and may shrink texts
          Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                  child: Text('\$${spentAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          Container(
            //know height from constraints
            height: constraints.maxHeight * .6,
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
            height: constraints.maxHeight * .05,
          ),
          Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(child: Text(labelTxt))),
        ],
      );
    }));
  }
}
