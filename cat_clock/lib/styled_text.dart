import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const StyledText(this.text,
      {this.fontSize, this.fontWeight = FontWeight.w400});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Open Sans",
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: fontWeight,
      ),
    );
  }
}
