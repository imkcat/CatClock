import 'package:cat_clock/clock_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class CatClock extends StatefulWidget {
  const CatClock(this.model);

  final ClockModel model;

  @override
  _CatClockState createState() => _CatClockState();
}

class _CatClockState extends State<CatClock> {
  Widget mask(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0,
            0.25,
            0.75,
            1
          ],
              colors: [
            Color.fromARGB(150, 0, 0, 0),
            Color.fromARGB(0, 0, 0, 0),
            Color.fromARGB(0, 0, 0, 0),
            Color.fromARGB(150, 0, 0, 0)
          ])),
    );
  }

  Widget clockFace(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListWheelScrollView(
          // physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ClockText(
              "1",
              fontSize: constraints.maxHeight,
            ),
            ClockText(
              "2",
              fontSize: constraints.maxHeight,
            ),
            ClockText(
              "3",
              fontSize: constraints.maxHeight,
            ),
            ClockText(
              "4",
              fontSize: constraints.maxHeight,
            )
          ],
          itemExtent: constraints.maxHeight,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          clockFace(context),
          IgnorePointer(
            child: mask(context),
          )
        ],
      ),
    );
  }
}
