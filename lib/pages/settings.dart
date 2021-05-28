import 'dart:convert';
import 'package:dating/auth/edit-profile.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/widgets/texttile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
   final MainModel model;
  Settings({this.model,
  });

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

   @override
   void initState() {
    _getAll();
    super.initState();
  }
  Map<String, dynamic> userInfo;
  String token;
  Map<String, dynamic> userInfo1;

_getAll() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
      userInfo1 = await json.decode(prefs.getString('datingUser'));
  setState(() {
       userInfo = userInfo1;
      //  print(userInfo);
        token = prefs.getString('datingToken');
  });
}

  @override
  Widget build(BuildContext context) {
    _logout() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // backgroundColor: black2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              title: Text(
                'Exit App',
              ),
              content: Text(
                'Are you sure you want to exit app?',
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Cancel",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 20.0, left: 12, top: 12, bottom: 12),
                    child: Text(
                      "Yes",
                    ),
                  ),
                )
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: cstart,
              children: <Widget>[
                SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2.0),
                  child: ListTile(
                    onTap: () =>
                              // Navigator.pushNamed(context, "/editprofile"),
                                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return EditProfile(
                            userInfo: userInfo,token:token, model: widget.model);
                      },
                    ),
                  ),
                    leading: Icon(
                      Icons.person,
                      color: secondary,
                      size: 20,
                    ),
                    title: Text('Edit Profile'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: ListTile(
                    onTap: () => Navigator.pushNamed(context, "/resetpwd"),
                    leading: Icon(
                      Icons.vpn_key,
                      color: secondary,
                      size: 20,
                    ),
                    title: Text('Reset Password'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: TextTile(
                    text: 'Others',
                    color: primary.withOpacity(0.7),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1.0),
                  child: ListTile(
                    title: Text('Terms'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1.0),
                  child: ListTile(
                    title: Text('Privacy'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1.0),
                  child: ListTile(
                    title: Text('Contact'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              margin: EdgeInsets.symmetric(vertical: 0),
              child: ListTile(
                onTap: _logout,
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                leading: Icon(
                  Icons.exit_to_app,
                  color: secondary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
