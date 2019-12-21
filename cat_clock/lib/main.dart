import 'package:cat_clock/cat_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';

void main() => runApp(ClockCustomizer((ClockModel model) => CatClock(model)));
