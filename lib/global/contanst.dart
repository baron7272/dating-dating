import 'package:flutter/material.dart';

//Colors
Color transparent = Colors.transparent;
Color black = Colors.black;
Color black45 = Colors.black45;
Color white = Colors.white;
Color red = Colors.red;
Color grey = Colors.grey;
Color black12 = Colors.black12;
Color primary = Color(0xFF2B3046);
Color secondary = Color(0xFFFE6F73);
Color accent = Color(0xFF727790);
Color iconWhite = Color(0xFFF9F7F7);

//Alignmnet
MainAxisAlignment mstart = MainAxisAlignment.start;
MainAxisAlignment mend = MainAxisAlignment.end;
MainAxisAlignment mcenter = MainAxisAlignment.center;
MainAxisAlignment mspacearound = MainAxisAlignment.spaceAround;
MainAxisAlignment mspacebetween = MainAxisAlignment.spaceBetween;
MainAxisAlignment mspaceevenly = MainAxisAlignment.spaceEvenly;

CrossAxisAlignment cstart = CrossAxisAlignment.start;
CrossAxisAlignment cend = CrossAxisAlignment.end;
CrossAxisAlignment ccenter = CrossAxisAlignment.center;
CrossAxisAlignment cstretch = CrossAxisAlignment.stretch;

//MediaQuery
double height(context) => MediaQuery.of(context).size.height;
double width(context) => MediaQuery.of(context).size.width;

//Decoration

final decoration = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: white,
  boxShadow: <BoxShadow>[
    BoxShadow(
        color: black45.withOpacity(0.2),
        spreadRadius: 1,
        // offset: Offset(1, 1),
        blurRadius: 2)
  ],
);
