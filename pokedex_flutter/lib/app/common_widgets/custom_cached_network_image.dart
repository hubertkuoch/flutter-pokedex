/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
// Pub.dev packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final String imageURL;

  const CustomCachedNetworkImage({
    Key key,
    @required this.imageURL,
  }) : super(key: key);

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      imageBuilder: (context, cachedImage) => Image(
        image: cachedImage,
      ),
      placeholder: (context, url) => JumpingText('Loading...'),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
