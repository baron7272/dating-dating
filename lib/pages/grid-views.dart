import 'package:dating/global/contanst.dart';
import 'package:dating/global/data.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:flutter/material.dart';

class GridViews extends StatefulWidget {
  // final List<Map<String, dynamic>> list;
  //  final bool myProfile;
   final MainModel model;
  //  final String token;
  final Map<String, dynamic> userInfo;

  GridViews({this.model,this.userInfo,

  });

  // GridViews({
  //   this.list,
  // });

  @override
  _GridViewsState createState() => _GridViewsState();
}

class _GridViewsState extends State<GridViews> {
  @override
  Widget build(BuildContext context) {
    var list = slideList;
    return list.length == 0
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: cstart,
              children: <Widget>[
                Text(
                  'Album',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 12),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(1.5),
                        height: 100,
                        child: Image.asset(
                          list[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          );
  }
}
