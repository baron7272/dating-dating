import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Widget suffixIcon;
  final String hintText;
  final TextInputType keyboardType;
  final bool enabled;
  final bool obscure;
  final Function(String) validator;
   final Function(String) onSaved;
   final TextStyle errorTextStyle;
  final Color textColor;
  List inputFormatters;
  TextEditingController controller;

  InputField({
    this.inputFormatters,
    this.hintText,
    this.keyboardType,
    this.obscure = false,
    this.textColor = Colors.black54,
    this.enabled = true,
    this.suffixIcon,
    this.errorTextStyle,
    this.validator,
    this.onSaved,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
         inputFormatters: inputFormatters,
        style: TextStyle(color: textColor, fontSize: 18.0),
        validator: validator,
        onSaved: onSaved,
        enabled: enabled,
        keyboardType: keyboardType,
        obscureText: obscure,
        decoration: InputDecoration(
          errorStyle: errorTextStyle,
          hintText: hintText,
          hintStyle: TextStyle(color: textColor, fontSize: 18.0),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: suffixIcon,
          // errorStyle: TextStyle(
          //   fontSize: 16,
          // ),
          errorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
