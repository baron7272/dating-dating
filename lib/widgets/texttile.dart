import 'package:flutter/material.dart';

class TextTile extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final TextAlign textAlign;
  final TextOverflow overflow;

  TextTile({
    this.text,
    this.color = Colors.black,
    this.fontSize = 14,
    this.fontWeight,
    this.height,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        textAlign: textAlign,
        overflow: overflow,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
    );
  }
}
