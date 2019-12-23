import 'dart:math';

import 'package:flutter/material.dart';

class Bubble extends StatefulWidget {
  final Widget child;
  final Color color;
  final bool enableScaleAnimation;
  final Duration scaleAnimationDuration;
  final double minScaleValue;
  final double maxScaleValue;

  Bubble({
    Key key,
    this.child,
    this.color = Colors.black,
    this.enableScaleAnimation = true,
    this.scaleAnimationDuration = const Duration(seconds: 3),
    this.minScaleValue = 0.95,
    this.maxScaleValue = 1.05,
  }) : super(key: key);

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with SingleTickerProviderStateMixin {
  AnimationController _scaleAnimationController;
  Animation<double> _scaleAnimation;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _scaleAnimationController = AnimationController(
      duration: widget.scaleAnimationDuration,
      vsync: this,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.easeInOut,
    );
    _scaleAnimation =
        Tween(begin: widget.minScaleValue, end: widget.maxScaleValue)
            .animate(_curvedAnimation);
  }

  Widget scaleAnimationWidget(BuildContext context, Widget child) {
    _scaleAnimationController.repeat(reverse: true);

    return widget.enableScaleAnimation
        ? ScaleTransition(
            child: child,
            scale: _scaleAnimation,
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return scaleAnimationWidget(
          context,
          Stack(
            children: <Widget>[
              CustomPaint(
                painter: BubblePainter(color: widget.color),
                size: constraints.biggest,
              ),
              if (widget.child != null) widget.child
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
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
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BubblePainter oldDelegate) => false;
}
