import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/model/user.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/utils/config-utils.dart';
import 'package:dating/utils/network-utils.dart';
import 'package:dating/widgets/button.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  final MainModel model;

  ResetPassword({this.model});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void initState() {
    _getAll();
    super.initState();
  }

  String _oldPwd = '';
  String _newPwd = '';
  final _scaffoldKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  static final resetPassword = '${ConfigUtils.getAPI()}/resetPassword';

   Map<String, dynamic> userInfo;
  String token;
  Map<String, dynamic> userInfo1;

  _getAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
userInfo1 = await json.decode(prefs.getString('datingUser'));
  setState(() {
       userInfo = userInfo1;
      token = prefs.getString('datingToken');
    });
  }


 

  _authenticate(
      BuildContext context, String newpassword, String olsPassword) async {
    Map<String, dynamic> _userData = {
      'newPassword': newpassword,
      'olsPassword': olsPassword,
    };

    NetworkUtils.loadingData(context);
    try {
      String url = Uri.encodeFull(resetPassword);

      return await http
          .post('$url',
              headers: {
                'Authorization': 'Bearer $token',
              },
              body: _userData)
          .then((http.Response response) async {
        Map<String, dynamic> result = json.decode(response.body);

        if (result.containsKey('success')) {
          final SharedPreferences _prefs =
              await SharedPreferences.getInstance();
          User __user = widget.model.setUser(result['userDetails']['user']);

          _prefs.setString('datingToken', result['userDetails']['token']);

          _prefs.setString('datingUser', json.encode(__user.toMap()));

          if (result.containsKey('source')) {
           
          await Firestore.instance
              .collection('users')
              .document(userInfo['firebaseId'])
              .updateData({
            'password': newpassword,
          
          }).then((data) async {
              // Navigator.of(context).pop();
              //  Navigator.of(context).pop();
              //  Navigator.pushNamed(context, "/editprofile");
           
          }).catchError((err) {
            Navigator.of(context).pop();
            Flushbar(
              backgroundColor: Colors.black,
              title: "Edit Profile",
              message: err,
              duration: Duration(seconds: 5),
            )..show(context);
          });

          Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
            Navigator.pushNamedAndRemoveUntil(
                context, '/maintabs', (_) => false);

            // DocumentSnapshot variable = await Firestore.instance.collection('users').document('8EOG5sCr3eT9CC2vpM0d6QhtnHV2').get();

            //  .collection('/users').document('8EOG5sCr3eT9CC2vpM0d6QhtnHV2').get();
            //  print(variable['email']);
            // AuthService.login(context, email, password);
          }
        } else {
          Navigator.of(context).pop();
          Flushbar(
            backgroundColor: Colors.black,
            title: "SigIn",
            message: result['error'],
            duration: Duration(seconds: 5),
          )..show(context);
        }
      });
    } catch (e) {
      print(e);
      print('ll.....a...........');
      Navigator.of(context).pop();
      Flushbar(
        backgroundColor: Colors.black,
        title: "SigIn",
        message: 'Network failed!',
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.0),
            child: Column(
              children: [
                SizedBox(height: 80.0),
                TextFormField(
                  initialValue: _oldPwd,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Old Password",
                      border: OutlineInputBorder(),
                      isDense: true),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _oldPwd = value;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: _newPwd,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                      isDense: true),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newPwd = value;
                  },
                ),
                SizedBox(height: 40.0),
                Button(
                  label: 'Reset',
                  radius: 4,
                  color: secondary,
                  width: width(context),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      _authenticate(context, _newPwd, _oldPwd);
                    }
                  },
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
