import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

class MessengerIcon extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  MessengerIcon({
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primary,
        shape: BoxShape.circle,
      ),
      height: 32.0,
      width: 32.0,
      margin: EdgeInsets.only(left: 8.0),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 17.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
