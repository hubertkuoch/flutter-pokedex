/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
// Internal modules
import 'package:pokedex_flutter/app/utils/palette.dart';

class TypeLabel extends StatelessWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final String type;
  final String text;

  const TypeLabel({Key key, this.type, @required this.text}) : super(key: key);

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 3.0,
      ),
      decoration: BoxDecoration(
        color: (type != null) ? palette[type][Tone.dark] : Colors.teal,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
