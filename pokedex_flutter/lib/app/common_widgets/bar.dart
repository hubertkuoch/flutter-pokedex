/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'dart:math';
import 'package:flutter/material.dart';
// Internal modules
import 'package:pokedex_flutter/app/utils/constants.dart';

class Bar extends StatelessWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final String label;
  final int stat;
  final Color color;

  const Bar({Key key, this.stat, this.label, this.color}) : super(key: key);

  final int maxStat = 200;
  final double maxBarWidth = 200;

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    final barWidth = min(stat / maxStat * maxBarWidth, maxBarWidth);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: 130.0,
          child: Text(label, style: kTabViewSubTitle),
        ),
        SizedBox(width: 5.0),
        Container(
          alignment: Alignment.center,
          width: 30.0,
          child: Text(
            stat.toString(),
          ),
        ),
        SizedBox(width: 5.0),
        Stack(
          children: <Widget>[
            Container(
              width: maxBarWidth,
              height: 10.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            Container(
              width: barWidth,
              height: 10.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
