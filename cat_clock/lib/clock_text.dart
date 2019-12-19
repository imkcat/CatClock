import 'package:flutter/material.dart';

class ClockText extends StatelessWidget {
  final String text;
  final double fontSize;

  const ClockText(this.text, {this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontFamily: "Montserrat", fontSize: fontSize),
    );
  }
}
