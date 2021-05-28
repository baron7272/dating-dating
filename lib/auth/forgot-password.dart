import 'dart:convert';

import 'package:dating/auth/verify.dart';
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

class ForgotPassword extends StatefulWidget {
  final MainModel model;

  const ForgotPassword({Key key, this.model}) : super(key: key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email;
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  final _scaffoldKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  static final forgetPass = '${ConfigUtils.getAPI()}/auth/forgotPassword';

  _authenticate(BuildContext context, String email) async {
    Map<String, dynamic> _userData = {
      'email': email,
    };

    NetworkUtils.loadingData(context);
    try {
      String url = Uri.encodeFull(forgetPass);

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

          User __user = widget.model.setUser(result['userDetails']['user']);
          _prefs.setString('datingUser', json.encode(__user.toMap()));
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Verify(
                    result: result, model: widget.model, source: 'forgetPass');
              },
            ),
          );
        } else {
          Navigator.of(context).pop();
          Flushbar(
            backgroundColor: Colors.black,
            title: "Forget password",
            message: result['error'],
            duration: Duration(seconds: 5),
          )..show(context);
        }
      });
    } catch (e) {
      Navigator.of(context).pop();
      Flushbar(
        backgroundColor: Colors.black,
        title: "Forget password",
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
                title: Text('Password Recovery'),
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
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _email = input,
                          validator: (String value) {
                            RegExp regExp = RegExp(pattern);
                            // debugPrint(value);
                            if (value.isEmpty) {
                              return 'Email address required!';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            } else {
                              return null;
                            }
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
                                _authenticate(context, _email);
                              }
                            },
                            label: 'Submit',
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
