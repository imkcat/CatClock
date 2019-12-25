import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Bubble extends StatefulWidget {
  final Widget child;
  final Color color;
  final bool enableScaleAnimation;
  final Duration scaleAnimationDuration;
  final Duration floatingAnimationDuration;

  Bubble({
    Key key,
    this.child,
    this.color = Colors.blue,
    this.enableScaleAnimation = true,
    this.scaleAnimationDuration = const Duration(seconds: 3),
    this.floatingAnimationDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with SingleTickerProviderStateMixin {
  Timer _floatingAnimationTimer;
  double _floatingVertical = 0;
  double _floatingHorizontal = 0;

  @override
  void initState() {
    super.initState();
    _floatingAnimationTimer =
        Timer.periodic(widget.floatingAnimationDuration, (timer) {
      setState(() {
        Random random = Random();
        _floatingVertical = random.nextInt(20).toDouble();
        _floatingHorizontal = random.nextInt(20).toDouble();
      });
    });
  }

  Widget floatingAnimationWrapper(Widget child) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        AnimatedPositioned(
            child: child,
            curve: Curves.easeInOut,
            duration: widget.floatingAnimationDuration,
            top: _floatingVertical,
            left: _floatingHorizontal)
      ],
    );
  }

  Widget scaleAnimationWrapper(Widget child) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: widget.scaleAnimationDuration,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double smallestSide =
            min(constraints.biggest.width, constraints.biggest.height);
        return floatingAnimationWrapper(
          scaleAnimationWrapper(
            Container(
              child: Stack(
                children: <Widget>[
                  CustomPaint(
                    painter: BubblePainter(color: widget.color),
                    size: Size.square(smallestSide),
                  ),
                  if (widget.child != null) widget.child
                ],
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.color,
                    blurRadius: 10,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
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
    // canvas.drawShadow(
    //   Path()
    //     ..arcTo(
    //       Rect.fromLTWH(0, 0, radius, radius),
    //       0,
    //       2 * pi,
    //       false,
    //     ),
    //   color,
    //   10,
    //   false,
    // );
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BubblePainter oldDelegate) => false;
}
