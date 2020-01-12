import 'dart:async';

import 'package:cat_clock/sky_controller.dart';
import 'package:cat_clock/styled_text.dart';
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

  Widget weather(double heightUnit) {
    return Icon(
      widget.model.weatherCondition.weatherIcon(),
      color: Colors.white,
      size: heightUnit * 2,
    );
  }

  Widget address(double heightUnit) {
    return SizedBox(
      height: heightUnit * 0.7,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: StyledText(
          widget.model.location,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget temperature(double heightUnit) {
    double temperature = widget.model.temperature;
    return SizedBox(
      height: heightUnit * 1.5,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: StyledText(
          "${temperature.round()}°",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget date(double heightUnit) {
    return SizedBox(
      height: heightUnit * 0.8,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: StyledText(
          "${DateFormat("EEE").format(_clockDateTime)} ${DateFormat("MM-dd").format(_clockDateTime)}",
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget time(double heightUnit) {
    return SizedBox(
      height: heightUnit * 2,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: StyledText(
          "${DateFormat("HH:mm").format(_clockDateTime)}",
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget frontWidgets(double heightUnit) {
    return Padding(
      padding: EdgeInsets.all(heightUnit),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                address(heightUnit),
                Spacer(),
                weather(heightUnit),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                temperature(heightUnit),
                Spacer(),
                date(heightUnit),
                time(heightUnit),
              ],
            ),
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
