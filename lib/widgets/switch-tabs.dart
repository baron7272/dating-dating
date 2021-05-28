import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

import 'animated-button.dart';

class SwitchTabs extends StatefulWidget {
  final List<String> options;
  final ValueChanged<int> onSelect;
  final Color selectedBackgroundColor;
  final Color selectedTextColor;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double elevation;

  SwitchTabs(
      {Key key,
      this.options,
      this.onSelect,
      this.selectedBackgroundColor,
      this.selectedTextColor,
      this.margin,
      this.padding,
      this.elevation})
      : super(key: key);

  @override
  _SwitchTabsState createState() => new _SwitchTabsState();
}

class _SwitchTabsState extends State<SwitchTabs> {
  int _pos = 0;

  void _onTap(int pos) {
    setState(() {
      _pos = pos;
    });
    widget.onSelect(_pos);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedButton(
          onTap: () => _onTap(0),
          cardColor: _pos == 0 ? secondary : secondary.withOpacity(0.4),
          elevation: 0,
          height: 40,
          width: 150,
          color: _pos == 0 ? secondary : secondary.withOpacity(0.4),
          option: widget.options[0],
        ),
        AnimatedButton(
          onTap: () => _onTap(1),
          cardColor: _pos == 1 ? secondary : secondary.withOpacity(0.4),
          elevation: 0,
          height: 40,
          width: 150,
          color: _pos == 1 ? secondary : secondary.withOpacity(0.4),
          option: widget.options[1],
        ),
      ],
    );
  }
}
