import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double radius;
  final Color color;
  final String label;
  final Color labelColor;
  final double width;
  final bool isSubmitting;
  final Function onPressed;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double fontSize;
  final double elevation;

  Button({
    this.color,
    this.label,
    this.labelColor = Colors.white,
    this.onPressed,
    this.padding,
    this.margin,
    this.elevation,
    this.radius = 8.0,
    this.width = 200.0,
    this.fontSize = 18.0,
    this.isSubmitting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      color: color,
      clipBehavior: Clip.antiAlias,
      child: Container(
        margin: margin,
        child: MaterialButton(
          highlightColor: transparent,
          padding: padding,
          minWidth: width,
          elevation: elevation,
          height: 50,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: labelColor,
              fontFamily: 'SFUIDisplay',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
