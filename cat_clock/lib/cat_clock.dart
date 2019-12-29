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
  Bubble _hourBubble;

  Widget hourBubble(double bubbleSide) {
    return Positioned(
      child: _hourBubble,
    );
  }

  Widget minuteBubble(BuildContext context, double bubbleSide) {
    return Positioned(
      right: 0,
      width: bubbleSide,
      height: bubbleSide,
      child: Bubble(
        color: Colors.blue,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "59",
            style: TextStyle(color: Colors.white),
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
  void initState() {
    super.initState();

    _hourBubble = Bubble(
      lifeCycleDuration: Duration(seconds: 1),
      color: Colors.red,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SizedBox.fromSize(
              size: constraints.biggest * 0.7,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "59",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
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
          child: GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  hourBubble(clockBubbleSide),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
