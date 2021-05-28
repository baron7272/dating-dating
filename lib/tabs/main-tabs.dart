import 'dart:convert';

import 'package:dating/global/contanst.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activity.dart';
import 'discover.dart';
import 'inbox.dart';
import 'likes.dart';
import 'profile.dart';

class MainTabs extends StatefulWidget {
  final MainModel model;
  final String link;
  final List userList;
  // final Map<String, dynamic> user;

   MainTabs({
      // this.user,
      this.model,
      this.userList,
      this.link});
  @override
  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
   @override
   void initState() {
    _getAll();
    super.initState();
  }
  final PageStorageBucket bucket = PageStorageBucket();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  Map<String, dynamic> userInfo;
  String token;
   String uid;

_getAll() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
       Map<String, dynamic>  userInfoSub  = await json.decode(prefs.getString('datingUser'));
      //  print(userInfoSub['firebaseId']);
   String  uidSub = await userInfoSub['firebaseId'];
  setState(() {
     userInfo = userInfoSub;
     uid=uidSub;
      token = prefs.getString('datingToken');
  });
}
   
 _displayChild(int index) {
    final List<Widget> screens = [
    Discover(),
    Likes(model: widget.model,uid:uid),
    Inbox(model: widget.model,),
    Activity(model: widget.model,),
    Profile(model: widget.model, userInfo : userInfo,token :token),
    ];
    return screens[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         key: _scaffoldKey,
      body: PageStorage(
        child: _displayChild(_currentIndex),
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(
            () {
              _currentIndex = i;
            },
          );
        },
        selectedItemColor:
            _currentIndex == 0 || _currentIndex == 4 ? white : primary,
        elevation: 0,
        unselectedItemColor: grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            _currentIndex == 0 || _currentIndex == 4 ? primary : white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Discover'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Likes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            title: Text('Inbox'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Activity'),),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
