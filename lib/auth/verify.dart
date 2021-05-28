import 'dart:async';
import 'dart:convert';
import 'package:dating/global/contanst.dart';
import 'package:dating/model/user.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/utils/config-utils.dart';
import 'package:dating/utils/network-utils.dart';
import 'package:dating/widgets/button.dart';
import 'package:dating/widgets/input-field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Verify extends StatefulWidget {
  final MainModel model;
  final String source;

  final Map<String, dynamic> result;
  const Verify({Key key, this.model, this.result, this.source})
      : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final _scaffoldKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  String _token;
  bool resend = true;
  bool resent = false;
  Timer _timer;
  int _start;

  static final regUrl = '${ConfigUtils.getAPI()}/auth/verify';
  static final reSend = '${ConfigUtils.getAPI()}/auth/resend';

  _authenticate(BuildContext context, String code) async {
    Map<String, dynamic> _userData = {
      'token': code.toString(),
      'source': widget.source,
      'email': widget.result['userDetails']['user']['email'],
    };
    NetworkUtils.loadingData(context);
    try {
      String url = Uri.encodeFull(regUrl);

      return await http
          .post('$url',
              headers: {
                // 'Authorization': 'Bearer $token',
              },
              body: _userData)
          .then((http.Response response) async {
        Map<String, dynamic> result = json.decode(response.body);

        if (result.containsKey('success')) {
          final SharedPreferences _prefs =
              await SharedPreferences.getInstance();

          _prefs.setString(
              'datingToken', widget.result['userDetails']['token']);

          User __user =
              widget.model.setUser(result['userDetails']['user']);
          _prefs.setString('datingUser', json.encode(__user.toMap()));

          Navigator.of(context).pop();

          if (result['source'] == 'forgetPass') {
            Navigator.pushNamedAndRemoveUntil(
                context, '/createPwd', (_) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/maintabs', (_) => false);
          }
        } else {
          Navigator.of(context).pop();
          Flushbar(
            backgroundColor: Colors.black,
            title: "Sign Up",
            message: result['error'],
            duration: Duration(seconds: 5),
          )..show(context);
        }
      });
    } catch (e) {
      Navigator.of(context).pop();
      Flushbar(
        backgroundColor: Colors.black,
        title: "Verification",
        message: 'Network failed!',
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              resend = true;
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  _resend(BuildContext context) async {
    Map<String, dynamic> _userData = {
      'email': widget.result['userDetails']['user']['email'],
    };
    NetworkUtils.loadingData(context);

    try {
      setState(() {});
      String url = Uri.encodeFull(reSend);

      return await http
          .post('$url', headers: {}, body: _userData)
          .then((http.Response response) async {
        Map<String, dynamic> result = json.decode(response.body);

        if (result.containsKey('success')) {
          setState(() {
            resent = true;
            resend = false;
            _start = 10;
            _timer = null;
          });

          startTimer();

          Navigator.of(context).pop();
        } else {
          Flushbar(
            backgroundColor: Colors.black,
            title: "Notice",
            message: result['error'],
            duration: Duration(seconds: 5),
          )..show(context);
        }
      });
    } catch (e) {
      Flushbar(
        backgroundColor: Colors.black,
        title: "Notice",
        message: e.toString(),
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
                title: Text('Email Verification'),
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
                          resent
                              ? Center(
                                  child: Text(
                                  'A code was sent to your email',
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ))
                              : Text(''),
                          InputField(
                            keyboardType: TextInputType.number,
                            hintText: 'Verification code',
                            onSaved: (input) => _token = input,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter a valid code!';
                              } else if (value.length <= 3) {
                                return 'Enter a valid code!';
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
                                  _authenticate(context, _token);
                                }
                              },
                              label: 'Submit',
                              color: secondary,
                              fontSize: 16,
                            ),
                          ),
                          resend
                              ? Button(
                                  onPressed: () {
                                    _resend(context);
                                  },
                                  label: 'Resend',
                                  color: secondary,
                                  fontSize: 16,
                                )
                              : Text('')
                        ],
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
