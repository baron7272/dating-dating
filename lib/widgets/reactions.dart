import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

class Reactions extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color color;

  Reactions({
    this.icon,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: white,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconWhite,
        ),
      ),
    );
  }
}

// Color(0xFFFBF9F9)