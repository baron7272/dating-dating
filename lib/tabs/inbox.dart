import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/global/data.dart';
import 'package:dating/pages/new_chat.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/widgets/texttile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Inbox extends StatefulWidget {
    final MainModel model;
   Inbox({
      this.model});
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String _time = DateFormat('kk:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("contact")
            .getDocuments()
            .asStream(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(height: 10),
                  Text('Please, wait!!!')
                ],
              ),
            );
          }
          print(snapshot.data.documents);
          return ListView.builder(
            // separatorBuilder: (BuildContext context, index) => Divider(),
            primary: false,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, index) => GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/chat"),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 8,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  dense: true,
                  leading: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: black12,
                        backgroundImage: AssetImage(slideList[index]["image"]),
                      ),
                      Positioned(
                        right: 2,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  title: Row(
                    mainAxisAlignment: mspacebetween,
                    children: <Widget>[
                      Expanded(
                        child: TextTile(
                          text: 'Jennifer Lawrence',
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _time,
                        style: TextStyle(color: grey, fontSize: 12),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextTile(
                          text:
                          'Jennifer Lawrence Jennifer Lawrence Jennifer Lawrence',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        decoration:
                        BoxDecoration(shape: BoxShape.circle, color: secondary),
                        padding: EdgeInsets.all(6),
                        child: TextTile(
                          textAlign: TextAlign.center,
                          text: '100',
                          fontSize: 8,
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/contacts"),
        child: Icon(Icons.perm_contact_calendar),
        backgroundColor: secondary,
      ),
    );
  }
}
