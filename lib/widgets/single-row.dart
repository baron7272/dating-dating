import 'package:dating/widgets/texttile.dart';
import 'package:flutter/material.dart';

class SingleRow extends StatelessWidget {
  final String title, content;
  SingleRow({
    this.title,
    this.content,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: TextTile(
          text: title,
          color: Colors.white54,
          fontSize: 16,
        )),
        // SizedBox(width: 16),
        Expanded(
            child: TextTile(
          text: content,
          color: Colors.white54,
          fontSize: 16,
        )),
        // SizedBox(width: 40),
      ],
    );
  }
}
