import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

import 'texttile.dart';

class DoubleColumn extends StatelessWidget {
  final String title;
  final List<Widget> children;

  DoubleColumn({
    this.title,
    this.children,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: cstretch,
        children: [
          TextTile(
            text: title,
            color: white,
            fontSize: 18,
          ),
          SizedBox(height: 12),
          Card(
            margin: EdgeInsets.all(0),
            color: Colors.white12.withOpacity(0.1),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: cstart,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
