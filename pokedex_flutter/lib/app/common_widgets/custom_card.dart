/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
// Internal modules
import 'package:pokedex_flutter/app/utils/palette.dart';
import 'package:pokedex_flutter/app/utils/string_utils.dart';
import 'package:pokedex_flutter/app/common_widgets/type_label.dart';
import 'package:pokedex_flutter/app/common_widgets/custom_cached_network_image.dart';

class CustomCard extends StatelessWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final String color;
  final String name;
  final List<String> types;
  final String imageURL;

  const CustomCard({
    Key key,
    this.color,
    this.name,
    this.types,
    this.imageURL,
  }) : super(key: key);

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    return Card(
      color: palette[color][Tone.light],
      margin: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              name.capitalize(),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5.0),
            _buildTypes(types),
            SizedBox(height: 5.0),
            _buildImage(imageURL),
          ],
        ),
      ),
    );
  }

  Widget _buildTypes(List<String> types) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (var type in types) ...[
          TypeLabel(type: type, text: type),
        ],
      ],
    );
  }

  Widget _buildImage(String imageURL) {
    return Expanded(
      child: Hero(
        tag: imageURL,
        child: CustomCachedNetworkImage(imageURL: imageURL),
      ),
    );
  }
}
