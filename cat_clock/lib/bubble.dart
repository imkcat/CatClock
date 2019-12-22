import 'dart:math';

import 'package:flutter/material.dart';

class Bubble extends StatefulWidget {
  final Widget child;
  final Color color;

  Bubble({Key key, this.child, this.color = Colors.black}) : super(key: key);

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          painter: BubblePainter(color: widget.color),
          size: constraints.biggest,
        );
      },
    );
  }
}

class BubblePainter extends CustomPainter {
  final Color color;

  BubblePainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2;
    Paint paint = Paint();
    paint.color = color;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BubblePainter oldDelegate) => false;
}
