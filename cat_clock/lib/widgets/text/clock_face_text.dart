import 'package:flutter/material.dart';

class ClockFaceText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double heightUnit;

  const ClockFaceText(this.text, this.heightUnit,
      {this.fontSize, this.fontWeight = FontWeight.w400, this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: "Open Sans",
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: fontWeight,
          shadows: [
            Shadow(
              offset: Offset.zero,
              color: Colors.black.withOpacity(0.45),
              blurRadius: heightUnit * 0.08,
            )
          ]),
    );
  }
}
