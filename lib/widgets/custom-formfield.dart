import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final Function(String) validator;
  final bool enabled, borderEnabled;
  final String labelText, hintText;
  final TextInputType keyboardType;
  final bool obscure;
  final Widget suffixIcon;
  final BoxBorder border;
  final EdgeInsets margin;
  final int maxLength, maxLines;
  final FocusNode focusNode;
  CustomFormField(
      {this.validator,
      this.enabled = true,
      this.labelText,
      this.margin,
      this.keyboardType,
      this.obscure = false,
      this.suffixIcon,
      this.border,
      this.borderEnabled = true,
      this.focusNode,
      this.maxLines,
      this.maxLength,
      this.hintText = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        // style: TextStyle(color: white, fontSize: 18.0),
        validator: validator,
        enabled: enabled,
        keyboardType: keyboardType,
        obscureText: obscure,
        maxLines: maxLines,
        maxLength: maxLength,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: labelText,
          // hintStyle: TextStyle(color: white, fontSize: 18.0),
          border: borderEnabled ? OutlineInputBorder() : InputBorder.none,
          isDense: true,
          // enabledBorder: InputBorder.none,
          // suffixIcon: suffixIcon,
          errorStyle: TextStyle(
            // color: red200,
            fontSize: 16,
          ),
          errorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
