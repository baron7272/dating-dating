import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

class TypeMessage extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  TypeMessage({
    this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primary.withOpacity(0.08),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        maxLines: 5,
        minLines: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
        ),
        controller: controller,
        focusNode: focusNode,
      ),
    );
  }
}
