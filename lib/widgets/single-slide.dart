import 'package:dating/global/contanst.dart';
import 'package:flutter/material.dart';

import 'reactions.dart';

class SingleSlide extends StatefulWidget {
  final Function onPressed;
  final bool grouped;
  final double top, blur, offset;
  final String image;
  final String age;
  final String name;
  final Function singleAction, groupAction;

  SingleSlide({
    this.onPressed,
    this.grouped = false,
    this.blur,
    this.offset,
    this.top,
    this.age,
    this.name,
    this.image,
    this.groupAction,
    this.singleAction,
  });
  @override
  _SingleSlideState createState() => _SingleSlideState();
}

class _SingleSlideState extends State<SingleSlide> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeOutQuint,
          margin: EdgeInsets.only(top: widget.top, bottom: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(widget.image),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white10,
                  blurRadius: widget.blur,
                  offset: Offset(
                    widget.offset,
                    widget.offset,
                  ),
                )
              ]),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            margin: EdgeInsets.only(right: 20.0, left: 0, bottom: 20.0),
            decoration: BoxDecoration(
                color: black45.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            width: width(context),
            child: Column(
              crossAxisAlignment: cstart,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: iconWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SFUIDisplay',
                        ),
                        children: [
                          TextSpan(text: widget.name),
                          TextSpan(
                              text: widget.grouped ? '' : ", " + widget.age),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Container(
                  child: Row(
                    mainAxisAlignment: mspacebetween,
                    children: <Widget>[
                      Row(
                        children: [
                          widget.grouped
                              ? Container()
                              : Reactions(
                                  onPressed: null,
                                  icon: Icons.favorite,
                                ),
                          Reactions(
                            onPressed: null,
                            icon: Icons.person_add,
                          ),
                          Reactions(
                            onPressed: widget.grouped
                                ? widget.groupAction
                                : widget.singleAction,
                            icon: Icons.info,
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: null,
                            child: Image.asset(
                              "assets/images/share.png",
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 16),
                          child: widget.grouped
                              ? CircleAvatar(
                                  child: Icon(
                                    Icons.group,
                                    color: white,
                                  ),
                                  backgroundColor: secondary,
                                )
                              : Image.asset(
                                  'assets/flags/us.png',
                                  fit: BoxFit.cover,
                                  height: 30,
                                  width: 40,
                                )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
