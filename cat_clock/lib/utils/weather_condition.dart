import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

extension WeatherIcon on WeatherCondition {
  IconData weatherIcon() {
    IconData weatherIconData;
    switch (this) {
      case WeatherCondition.sunny:
        weatherIconData = MdiIcons.whiteBalanceSunny;
        break;
      case WeatherCondition.cloudy:
        weatherIconData = MdiIcons.weatherCloudy;
        break;
      case WeatherCondition.foggy:
        weatherIconData = MdiIcons.weatherFog;
        break;
      case WeatherCondition.rainy:
        weatherIconData = MdiIcons.weatherRainy;
        break;
      case WeatherCondition.snowy:
        weatherIconData = MdiIcons.weatherSnowy;
        break;
      case WeatherCondition.thunderstorm:
        weatherIconData = MdiIcons.weatherLightning;
        break;
      case WeatherCondition.windy:
        weatherIconData = MdiIcons.weatherWindy;
        break;
    }
    return weatherIconData;
  }
}
