import 'dart:async';

import 'package:flutter/material.dart';

class Bubble extends StatefulWidget {
  final Widget child;
  final Color color;
  final double side;
  final Duration lifeCycleDuration;
  final Duration showInAnimationDuration;
  final Duration showOutAnimationDuration;

  Bubble({
    Key key,
    this.child,
    this.color = Colors.blue,
    this.side = 50,
    this.lifeCycleDuration = Duration.zero,
    this.showInAnimationDuration = const Duration(seconds: 1),
    this.showOutAnimationDuration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with TickerProviderStateMixin {
  AnimationController _showInAnimationController;
  AnimationController _showOutAnimationController;
  Animation<double> _showInAnimation;
  Animation<double> _showOutAnimation;
  Timer _lifeCycleTimer;

  @override
  void initState() {
    super.initState();
    _showInAnimationController = AnimationController(
        duration: widget.showInAnimationDuration, vsync: this);
    _showOutAnimationController = AnimationController(
        duration: widget.showOutAnimationDuration, vsync: this);

    _showInAnimation = CurveTween(curve: Curves.elasticOut)
        .chain(Tween(begin: 0, end: 1))
        .animate(_showInAnimationController);
    _showOutAnimation = CurveTween(curve: Curves.elasticOut)
        .chain(Tween(begin: 1, end: 0))
        .animate(_showOutAnimationController);

    if (widget.lifeCycleDuration.compareTo(Duration.zero) > 0) {
      _lifeCycleTimer = Timer(widget.lifeCycleDuration, () {
        _showOutAnimationController.forward();
      });
    }
  }

  Widget showInTransition(Widget child) {
    return ScaleTransition(
      scale: _showInAnimation,
      child: child,
    );
  }

  Widget showOutTransition(Widget child) {
    return ScaleTransition(
      scale: _showOutAnimation,
      child: child,
    );
  }

  Widget bubble() {
    return SizedBox.fromSize(
      child: Container(
        child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: BubblePainter(color: widget.color),
              size: Size.square(widget.side),
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
      size: Size.square(widget.side),
    );
  }

  @override
  Widget build(BuildContext context) {
    _showInAnimationController.forward();

    return showInTransition(
      showOutTransition(
        bubble(),
      ),
    );
  }

  @override
  void dispose() {
    _showInAnimationController.dispose();
    _showOutAnimationController.dispose();
    super.dispose();
  }
}

class BubblePainter extends CustomPainter {
  final Color color;

  BubblePainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Paint paint = Paint();
    paint.color = color;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BubblePainter oldDelegate) => false;
}
