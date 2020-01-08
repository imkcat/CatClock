import 'package:cat_clock/sky_controller.dart';
import 'package:cat_clock/styled_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class CatClock extends StatefulWidget {
  const CatClock(this.model);

  final ClockModel model;

  @override
  _CatClockState createState() => _CatClockState();
}

class _CatClockState extends State<CatClock> with WidgetsBindingObserver {
  SkyController _skyController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _skyController = SkyController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget address() {
    return SizedBox(
      height: 30,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: StyledText(
          "San Francisco",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget temperature() {
    return SizedBox(
      height: 30,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: StyledText(
          "-23°",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget date() {
    return SizedBox(
      height: 30,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: StyledText(
          "MON 01-07",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget time() {
    return SizedBox(
      height: 30,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: StyledText(
          "11:26",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget frontWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        address(),
        temperature(),
        Spacer(),
        date(),
        time(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FlareActor(
            "assets/riva/Sky.flr",
            controller: _skyController,
            fit: BoxFit.cover,
          ),
          frontWidgets(),
        ],
      ),
    );
  }

  // WidgetsBindingObserver
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _skyController.refreshTime();
    }
    super.didChangeAppLifecycleState(state);
  }
}
