import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/model/user.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/utils/config-utils.dart';
import 'package:dating/utils/network-utils.dart';
import 'package:dating/widgets/button.dart';
import 'package:dating/widgets/input-field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePassword extends StatefulWidget {
  final MainModel model;

  CreatePassword({this.model});

  @override
  _CreatePasswordState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  @override
  initState() {
    _initData();
    super.initState();
  }

  Map<String, dynamic> userInfo;

  _initData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfo = json.decode(prefs.getString('datingUser'));
  }

  final _scaffoldKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  String _newPassword;
  bool _showPwd = true;
  static final _firestore = Firestore.instance;

  static final forgetPass = '${ConfigUtils.getAPI()}/auth/createPassword';

  _authenticate(BuildContext context, String password) async {
    Map<String, dynamic> _userData = {
      'password': password,
      'email': userInfo['email'],
    };

    NetworkUtils.loadingData(context);
    try {
      String url = Uri.encodeFull(forgetPass);

      return await http
          .post('$url', headers: {}, body: _userData)
          .then((http.Response response) async {
        Map<String, dynamic> result = json.decode(response.body);

        if (result.containsKey('success')) {
          final SharedPreferences _prefs =
              await SharedPreferences.getInstance();
              print('............');
 print(result['userDetails']['token']);
 
          _prefs.setString('datingToken', result['userDetails']['token']);
          print(result['userDetails']['user']);

          User __user = widget.model.setUser(result['userDetails']['user']);
          _prefs.setString('datingUser', json.encode(__user.toMap()));

          _firestore
              .collection('users')
              .document(result['userDetails']['user']['firebaseId'])
              .updateData({'password': password}).then((data) async {
            Navigator.of(context).pop();

            Navigator.pushNamedAndRemoveUntil(
                context, '/maintabs', (_) => false);
          }).catchError((err) {
            Navigator.of(context).pop();
            Flushbar(
              backgroundColor: Colors.black,
              title: "Create Password",
              message: err,
              duration: Duration(seconds: 5),
            )..show(context);
          });
        } else {
          Navigator.of(context).pop();
          Flushbar(
            backgroundColor: Colors.black,
            title: "Create Password",
            message: result['error'],
            duration: Duration(seconds: 5),
          )..show(context);
        }
      });
    } catch (e) {
      Navigator.of(context).pop();
      Flushbar(
        backgroundColor: Colors.black,
        title: "Create Password",
        message: 'Network failed!',
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage('assets/images/img1.jpg'),
                    //   fit: BoxFit.fitWidth,
                    //   alignment: Alignment.topCenter
                    // )
                    color: primary),
              ),
              AppBar(
                title: Text('Create Password'),
                centerTitle: true,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        InputField(
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPwd = !_showPwd;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                !_showPwd
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: grey,
                                size: 18,
                              ),
                            ),
                          ),
                          obscure: _showPwd,
                          onSaved: (input) => _newPassword = input,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid password!';
                            } else if (value.length <= 5) {
                              return 'Password must be above 5 Characters!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          child: Button(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form.validate()) {
                                form.save();
                                _authenticate(context, _newPassword);
                              }
                            },
                            label: 'Create',
                            color: secondary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
