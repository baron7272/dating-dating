import 'package:dating/global/contanst.dart';
import 'package:dating/widgets/button.dart';
import 'package:flutter/material.dart';

import 'texttile.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final String fee;
  final bool paid;
  final String duration;
  final Function onPressed;

  PlanCard({
    this.title,
    this.fee,
    this.paid = true,
    this.duration,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      // height: height(context)/2,
      child: Card(
        child: Stack(
          children: [
            // Column(
            //   children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30),
              height: 120,
              width: width(context),
              decoration: BoxDecoration(
                color: primary,
              ),
              child: TextTile(
                text: title.toUpperCase(),
                textAlign: TextAlign.center,
                color: white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),

            Positioned(
              top: paid ? 240 : 210,
              right: 0,
             left: 0,
              child: Center(
                child: Column(
                  children: [
                    // SizedBox(height: 50.0),
                    TextTile(
                      text: paid ? 'Unlimited Likes' : 'Limited Likes',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(height: 16.0),
                    TextTile(
                      text: paid ? 'No Adverts' : 'With Adverts',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(height: 16.0),
                    TextTile(
                      text: paid ? 'Unlimited Range' : 'Limited Range',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: paid ? 70.0 : 40.0),

            // SizedBox(height: 40.0),
            // Button(
            //   label: paid ? 'Purchase' : 'Subcribed',
            //   color: secondary,
            //   onPressed: onPressed,
            // )
            //   ],
            // ),
            Positioned(
              top: 70.0,
              right: 0,
              left: 0,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: secondary,
                  shape: BoxShape.circle,
                  border: Border.all(color: white, width: 2.0),
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$',
                          style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: fee,
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                        TextSpan(
                          text: '\nMonthly',
                          style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            paid
                ? Positioned(
                    top: 198,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: TextTile(
                        text: duration,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Button(
                  label: paid ? 'Purchase' : 'Subcribed',
                  color: secondary,
                  onPressed: onPressed,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
