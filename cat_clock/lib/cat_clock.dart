import 'dart:async';

import 'package:cat_clock/open_sans_text.dart';
import 'package:cat_clock/sky_controller.dart';
import 'package:cat_clock/utils/weather_condition.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

class CatClock extends StatefulWidget {
  const CatClock(this.model);

  final ClockModel model;

  @override
  _CatClockState createState() => _CatClockState();
}

class _CatClockState extends State<CatClock> with WidgetsBindingObserver {
  SkyController _skyController;
  Timer _clockTimer;
  DateTime _clockDateTime;

  @override
  void initState() {
    super.initState();

    _clockDateTime = DateTime.now();
    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _clockDateTime = _clockDateTime.add(Duration(seconds: 1));
      });
    });

    WidgetsBinding.instance.addObserver(this);
    _skyController = SkyController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _clockTimer.cancel();
    super.dispose();
  }

  Widget temperature(double heightUnit) {
    double temperature = widget.model.temperature;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: <Widget>[
        OpenSansText(
          "${temperature.round()}",
          fontWeight: FontWeight.w400,
          fontSize: heightUnit,
        ),
        OpenSansText(
          "°",
          fontWeight: FontWeight.w300,
          fontSize: heightUnit,
        ),
        Icon(
          widget.model.weatherCondition.weatherIcon(),
          color: Colors.white,
          size: heightUnit * 0.5,
        ),
      ],
    );
  }

  Widget address(double heightUnit) {
    return OpenSansText(
      widget.model.location,
      fontWeight: FontWeight.w400,
      fontSize: heightUnit * 0.5,
    );
  }

  Widget date(double heightUnit) {
    return OpenSansText(
      "${DateFormat("EEE").format(_clockDateTime)} ${DateFormat("MM-dd").format(_clockDateTime)}",
      fontWeight: FontWeight.w300,
      fontSize: heightUnit * 0.6,
    );
  }

  Widget time(double heightUnit) {
    return OpenSansText(
      "${DateFormat("HH:mm").format(_clockDateTime)}",
      fontWeight: FontWeight.w400,
      fontSize: heightUnit * 2,
    );
  }

  Widget frontWidgets(double heightUnit) {
    return Padding(
      padding: EdgeInsets.all(heightUnit),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              temperature(heightUnit),
              // weather(heightUnit),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[date(heightUnit)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              address(heightUnit),
              time(heightUnit),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ClipRect(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              FlareActor(
                "assets/riva/Sky.flr",
                controller: _skyController,
                fit: BoxFit.cover,
              ),
              frontWidgets(constraints.biggest.height / 10),
            ],
          ),
        );
      },
    );
  }

  // WidgetsBindingObserver
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _skyController.refreshTime();
      setState(() {
        _clockDateTime = DateTime.now();
      });
    }
    super.didChangeAppLifecycleState(state);
  }
}
