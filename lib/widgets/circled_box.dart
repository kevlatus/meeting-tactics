import 'package:flutter/material.dart';

class _ArtistCirclePainter extends CustomPainter {
  final Color color;

  _ArtistCirclePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    canvas.drawOval(
      rect,
      Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CircledBox extends StatelessWidget {
  final Widget child;

  const CircledBox({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child,
      ),
      painter: _ArtistCirclePainter(Theme.of(context).primaryColor),
    );
  }
}
