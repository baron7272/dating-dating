import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/auth/verify.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/model/user.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/services/auth_services.dart';
import 'package:dating/utils/config-utils.dart';
import 'package:dating/utils/network-utils.dart';
import 'package:dating/widgets/button.dart';
import 'package:dating/widgets/input-field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final MainModel model;
  final bool updateFound;
  final String link;
  Login({this.model, this.updateFound, this.link});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  static final login = '${ConfigUtils.getAPI()}/auth/login';

  _authenticate(BuildContext context, String email, String password) async {
    Map<String, dynamic> _userData = {
      'email': email,
      'password': password,
    };

    NetworkUtils.loadingData(context);
    try {
    String url = Uri.encodeFull(login);

    return await http
        .post('$url', headers: {}, body: _userData)
        .then((http.Response response) async {
      Map<String, dynamic> result = json.decode(response.body);

      if (result.containsKey('success')) {
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        User __user = widget.model.setUser(result['userDetails']['user']);

        _prefs.setString('datingToken', result['userDetails']['token']);

        _prefs.setString('datingUser', json.encode(__user.toMap()));

        if (result.containsKey('source')) {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Verify(
                    result: result, model: widget.model, source: 'register');
              },
            ),
          );
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: primary,
          body: Stack(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/images/people.jpg',
                  height: height(context),
                  width: width(context),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: black.withOpacity(0.5),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: height(context) / 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: primary.withOpacity(0.8),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeBottom: true,
                        removeTop: true,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            InputField(
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input) => _email = input,
                              validator: (String value) {
                                RegExp regExp = RegExp(pattern);

                                if (value.isEmpty) {
                                  return 'Email address required!';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 16.0),
                            InputField(
                              hintText: 'Password',
                              keyboardType: TextInputType.visiblePassword,
                              obscure: true,
                              onSaved: (input) => _password = input,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter a valid password!';
                                } else if (value.length <= 3) {
                                  return 'Enter a valid password!';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 20.0),
                              child: RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushNamed(
                                        context, "/forgotPwd"),
                                  style: TextStyle(
                                      fontFamily: 'SFUIDisplay',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: white),
                                  text: "Forgot Password?",
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 8.0),
                              child: Button(
                                onPressed: () {
                                  final form = _formKey.currentState;
                                  if (form.validate()) {
                                    form.save();
                                    _authenticate(context, _email, _password);
                                  }
                                },
                                label: 'LOGIN',
                                color: secondary,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Don't have an account?",
                                        style: TextStyle(
                                          fontFamily: 'SFUIDisplay',
                                          color: white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "  Register",
                                        style: TextStyle(
                                            fontFamily: 'SFUIDisplay',
                                            color: secondary,
                                            // color: Color(0xffff2d55),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () => Navigator.pushNamed(
                                              context, "/register"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              )
            ],
          )),
    );
  }
}
