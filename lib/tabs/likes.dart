import 'package:dating/global/contanst.dart';
import 'package:dating/pages/you-liked.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:flutter/material.dart';

class Likes extends StatefulWidget {
    final MainModel model;
    final String uid;

   Likes({
      this.model,this.uid,
  });
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Likes'),
          bottom: TabBar(
            indicatorColor: grey,
            tabs: [
              Tab(text: "You Liked"),
              Tab(text: "Liked You"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            YouLiked(model: widget.model,value:'youLikes',uid:widget.uid),
            YouLiked(model: widget.model,value:'LikesYou',uid:widget.uid),
          ],
        ),
      ),
    );
  }
}
