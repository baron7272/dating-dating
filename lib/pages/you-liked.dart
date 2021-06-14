import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/global/data.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YouLiked extends StatefulWidget {
  final MainModel model;
  final String value;
  final String uid;

  YouLiked({this.model, this.value, this.uid});

  @override
  _YouLikedState createState() => _YouLikedState();
}

class _YouLikedState extends State<YouLiked> {

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: Firestore.instance.collection("likes").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
          if (snapshot2.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoActivityIndicator(
                    radius: 15,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Please wait...')
                ],
              ),
            );
          }
          else if (snapshot2.data.documents != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot2.data.documents.length,
                primary: false,
                itemBuilder: (BuildContext context, index) {
                  print('==== ${snapshot2.data.documents[index]['userId']}');
                  return FutureBuilder(
                    future: Firestore.instance.collection('users').document(snapshot2.data.documents[index]['userId']).get(),
                    builder: (context, snapshot){

                      if(snapshot.data == null){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      print('8888 ${snapshot.data['photoUrl']}');
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: black12,
                          backgroundImage: NetworkImage(snapshot.data['photoUrl']),
                        ),
                        title: Text(snapshot.data['username']),
                        subtitle: Container(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: grey,
                              ),
                              children: [
                                TextSpan(text: 'Created At:'),
                                TextSpan(text: snapshot.data['createdAt']),
                              ],
                            ),
                          ),
                        ),
                        trailing: Icon(Icons.favorite, color: red),
                      );
                    },
                  );
                },
              ),
            );
          }
          return Center(
            child: Text('No internet connection'),
          );
        });
  }
}