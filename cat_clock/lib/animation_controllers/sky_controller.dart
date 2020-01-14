import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controls.dart';

class SkyController extends FlareControls {
  ActorAnimation _skyAnimation;
  double _time = 0;

  void refreshTime() {
    DateTime currentDateTime = DateTime.now();
    _time = currentDateTime.hour * 60 * 60 +
        currentDateTime.minute * 60 +
        currentDateTime.second.toDouble();
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    refreshTime();
    _skyAnimation = artboard.getAnimation("Sky");
    _skyAnimation.apply(_time / 86400 * _skyAnimation.duration, artboard, 1.0);
    play("Sky");
    play("Cloud Level 1 Idle");
    play("Cloud Level 2 Idle");
    play("Cloud Level 3 Idle");
    play("Cloud Level 4 Idle");
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    super.advance(artboard, elapsed);
    if (_skyAnimation == null) {
      return false;
    }
    _time += elapsed;
    _skyAnimation.apply(_time / 86400 * _skyAnimation.duration, artboard, 1.0);
    return true;
  }
}
