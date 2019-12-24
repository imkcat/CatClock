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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        double clockWidth = constrains.biggest.width;
        double clockHeight = constrains.biggest.height;
        double clockBubbleSide = clockHeight / 4 * 3;

        return ClipRect(
          child: Stack(
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: clockBubbleSide / 6 * 11,
                  height: clockBubbleSide,
                  child: Stack(
                    children: <Widget>[
                      minuteBubble(context, clockBubbleSide),
                      hourBubble(context, clockBubbleSide),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
