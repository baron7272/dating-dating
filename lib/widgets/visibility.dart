import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

class Visible extends StatefulWidget {
  @override
  _VisibleState createState() => _VisibleState();
}

class _VisibleState extends State<Visible> {
  bool visible = false;

  toggleButton() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 36,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: visible ? white : white,
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            top: 3.0,
            left: visible ? 60.0 : 0.0,
            right: visible ? 0.0 : 60.0,
            child: InkWell(
              onTap: toggleButton,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 1000),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                    turns: animation,
                    child: child,
                  );
                },
                child: visible
                    ? CircleAvatar(
                        radius: 15,
                        backgroundColor: secondary,
                        child: Text(
                          'ON',
                          style: TextStyle(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        key: UniqueKey(),
                      )
                    : CircleAvatar(
                        radius: 15,
                        backgroundColor: grey,
                        child: Text(
                          'OFF',
                          style: TextStyle(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        key: UniqueKey(),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
