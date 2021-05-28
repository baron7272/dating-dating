import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

class Bubble extends StatefulWidget {
  final bool isMe;
  final String name;
  final String message;
  final String time;
  final bool isSeen;
  final String image;
  final bool hasImage;
  Bubble({
    this.isMe = false,
    this.message,
    this.name,
    this.time,
    this.isSeen = false,
    this.image,
    this.hasImage = false,
  });

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  final double _fontSize = 16;

  double imgHeight = 350;

  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13.0),
            child: Container(
              decoration: BoxDecoration(
                color: secondary.withOpacity(0.5),
                gradient: LinearGradient(
                  colors: [
                    widget.isMe
                        ? secondary.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.5),
                    widget.isMe
                        ? secondary.withOpacity(0.8)
                        : Colors.grey.withOpacity(0.5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(widget.isMe ? 15.0 : 0),
                  bottomRight: Radius.circular(widget.isMe ? 0 : 15.0),
                ),
              ),
              constraints: BoxConstraints(
                maxWidth: width(context) / 1.3,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text.rich(buildMsg()),
            ),
          ),
          Positioned(
            right: 22,
            bottom: -2,
            child: Text.rich(buildTime()),
          )
        ],
      ),
    );
  }

  TextSpan buildMsg() {
    double imgWidth(context) => MediaQuery.of(context).size.width;
    return TextSpan(
      style: TextStyle(fontSize: _fontSize),
      children: [
        widget.hasImage
            ? WidgetSpan(
                child: GestureDetector(
                  // onTap: () => setState(() => tapped = !tapped),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    child: Image.asset(
                      widget.image,
                      height: imgHeight,
                      width: imgWidth(context) / 1.65,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : TextSpan(text: widget.message),
      ],
    );
  }

  TextSpan buildTime() {
    return TextSpan(
      children: [
        TextSpan(
          text: '11:45am ',
          style: TextStyle(fontSize: 10, color: grey),
        ),
        widget.isMe
            ? WidgetSpan(
                child: Icon(widget.isSeen ? Icons.done_all : Icons.done,
                    size: 14, color: widget.isSeen ? primary : grey),
                baseline: TextBaseline.alphabetic)
            : WidgetSpan(child: Container())
      ],
    );
  }
}
