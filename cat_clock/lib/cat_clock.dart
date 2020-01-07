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

  Widget time() {
    return Align(
      alignment: Alignment.centerRight,
      child: StyledText(
        "11:26",
        fontSize: 50,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: <Widget>[
          FlareActor(
            "assets/riva/Sky.flr",
            controller: _skyController,
            fit: BoxFit.cover,
          ),
          time(),
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
