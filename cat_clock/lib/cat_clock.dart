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
  Widget hourBubble(BuildContext context, double bubbleSide) {
    return Positioned(
      width: bubbleSide,
      height: bubbleSide,
      child: Bubble(
        color: Colors.red,
        enableScaleAnimation: false,
        child: Center(
          child: Text(
            "59",
            style: TextStyle(color: Colors.white, fontSize: 80),
          ),
        ),
      ),
    );
  }

  Widget minuteBubble(BuildContext context, double bubbleSide) {
    return Positioned(
      right: 0,
      width: bubbleSide,
      height: bubbleSide,
      child: Bubble(
        color: Colors.blue,
        enableScaleAnimation: false,
        child: Center(
          child: Text(
            "59",
            style: TextStyle(color: Colors.white, fontSize: 80),
          ),
        ),
      ),
    );
  }

  Widget majorBubble(Color color, double side) {
    return Expanded(
      child: Center(
        child: SizedBox(
          height: side,
          width: side,
          child: Bubble(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        double clockWidth = constrains.biggest.width;
        double clockHeight = constrains.biggest.height;
        double clockBubbleSide = clockHeight / 2;

        return ClipRect(
          child: Stack(
            children: <Widget>[
              Center(
                child: Row(
                  children: <Widget>[
                    majorBubble(Colors.red, clockBubbleSide),
                    majorBubble(Colors.blue, clockBubbleSide),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
