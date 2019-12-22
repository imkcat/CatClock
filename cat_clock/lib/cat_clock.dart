import 'package:cat_clock/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class CatClock extends StatefulWidget {
  const CatClock(this.model);

  final ClockModel model;

  @override
  _CatClockState createState() => _CatClockState();
}

class _CatClockState extends State<CatClock> {
  Widget hourBubble(BuildContext context, BoxConstraints constrains) {
    double width = constrains.biggest.width;
    double height = constrains.biggest.height;
    return Positioned(
      left: -height,
      width: height * 2,
      height: height * 2,
      child: Bubble(),
    );
  }

  Widget colonBubble(BuildContext context, BoxConstraints constrains) {
    double width = constrains.biggest.width;
    double height = constrains.biggest.height;
    return Positioned(
      right: 0,
      width: height / 2,
      height: height / 2,
      child: Bubble(),
    );
  }

  Widget minuteBubble(BuildContext context, BoxConstraints constrains) {
    double width = constrains.biggest.width;
    double height = constrains.biggest.height;
    return Positioned(
      right: 0,
      width: height / 2,
      height: height / 2,
      child: Bubble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Stack(
          children: <Widget>[
            hourBubble(context, constrains),
            minuteBubble(context, constrains)
          ],
        );
      },
    );
  }
}
