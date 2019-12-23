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
      left: 0,
      width: height,
      height: height,
      child: Bubble(
        color: Color.fromRGBO(231, 76, 60, 1),
        minScaleValue: 0.8,
        maxScaleValue: 1.2,
        child: Center(
          child: Text(
            "59",
            style: TextStyle(color: Colors.white, fontSize: 100),
          ),
        ),
      ),
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
      left: width / 2,
      top: (height - height * 2 / 3) / 2,
      width: height * 2 / 3,
      height: height * 2 / 3,
      child: Bubble(
        minScaleValue: 0.8,
        maxScaleValue: 1.2,
        child: Center(
          child: Text(
            "59",
            style: TextStyle(color: Colors.white, fontSize: 50),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return ClipRect(
          child: Stack(
            children: <Widget>[
              minuteBubble(context, constrains),
              hourBubble(context, constrains),
            ],
          ),
        );
      },
    );
  }
}
