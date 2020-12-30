import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SvgOrPngImage extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final BoxFit fit;
  final Color color;
  final Alignment alignment;

  const SvgOrPngImage(
    this.assetPath, {
    Key key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(
        '/assets/' + assetPath.replaceFirst('.png', '.svg'),
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
      );
    } else {
      return Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
      );
    }
  }
}
