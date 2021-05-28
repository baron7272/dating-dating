import 'package:dating/global/contanst.dart';
import 'package:dating/tabs/profile.dart';
import 'package:flutter/material.dart';

class InfoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Profile(myProfile: false,),
        Positioned(
          top: 40,right: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
                      child: Icon(
              Icons.cancel,
              color: white,
            ),
          ),
        ),
      ],
    );
  }
}
