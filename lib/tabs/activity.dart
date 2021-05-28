import 'package:dating/global/contanst.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/widgets/texttile.dart';
import 'package:flutter/material.dart';

class Activity extends StatefulWidget {
    final MainModel model;
    
   Activity({
      this.model,
   });
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, index) => Divider(),
        itemCount: 8,
        itemBuilder: (BuildContext context, index) => ListTile(
            title: Text('Group Request'),
            subtitle: Column(
              crossAxisAlignment: cstart,
              children: <Widget>[
                SizedBox(height: 6.0),
                TextTile(text: 'Mary requested to join your group if you would accept her request'),
                SizedBox(height: 6.0),
                Text('20-06-2020'),
              ],
            ),),
      ),
    );
  }
}

