import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final Color cardColor;
  final String option;
  final double elevation;
  final double width;
  final double height;
  final EdgeInsets margin;

  AnimatedButton({
    this.cardColor,
    this.color,
    this.elevation,
    this.height,
    this.onTap,
    this.option,
    this.width,
    this.margin = const EdgeInsets.symmetric(horizontal: 8)
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: cardColor,
        
        elevation: elevation,
        margin: margin,
        clipBehavior: Clip.antiAlias,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
          ),
          child: Text(
            option,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
