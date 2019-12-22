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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[Bubble()],
      ),
    );
  }
}
