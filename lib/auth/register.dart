import 'dart:io';

import 'package:dating/country_picker/country-picker-cupertino.dart';
import 'package:dating/country_picker/country-picker-dialog.dart';
import 'package:dating/country_picker/country-picker-utils.dart';
import 'package:dating/country_picker/country.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/global/disable-focusnode.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/services/auth_services.dart';
import 'package:dating/widgets/button.dart';
import 'package:dating/widgets/input-field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  final MainModel model;
  final bool updateFound;
  final String link;

  const Register({Key key, this.model, this.updateFound, this.link})
      : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final _authh = FirebaseAuth.instance;
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  String _country = 'Country';
  String _extension;
  Country _selectedCountry;
  bool _showPwd = true;
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _username, _isCode;

  void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: 300.0,
          onValuePicked: (Country country) {
            _country = country.name;
            _extension = '+${country.phoneCode}';
            setState(() => _selectedCountry = country);
          },
        );
      });

  Widget _buildDialogItem(Country country) => ListTile(
        leading: CountryPickerUtils.getDefaultFlagImage(country),
        title: Text(country.name),
        trailing: Text("+${country.phoneCode}"),
      );

  void _closeDialog() => Navigator.pop(_scaffoldKey.currentContext);

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.white),
          child: CountryPickerDialog(
              titlePadding: EdgeInsets.all(8.0),
              searchCursorColor: Colors.white,
              searchInputDecoration: InputDecoration(hintText: 'search...'),
              isSearchable: true,
              title: ListTile(
                leading: Icon(Icons.search),
                title: Text('select your country'),
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                trailing: GestureDetector(
                  onTap: _closeDialog,
                  child: Icon(Icons.close),
                ),
                dense: false,
              ),
              onValuePicked: (Country country) {
                _country = country.name;
                _isCode = country.isoCode;
                _extension = '+${country.phoneCode}';
                setState(() => _selectedCountry = country);
              },
              itemBuilder: _buildDialogItem),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          key: _scaffoldKey,
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
                margin: EdgeInsets.only(top: height(context) / 5.5),
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
                      removeTop: true,
                      removeBottom: true,
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
                          SizedBox(height: 12.0),
                          InputField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(
                                  new RegExp(r"\s\b|\b\s|[0-9.,]+"))
                            ],
                            hintText: 'Username',
                            keyboardType: TextInputType.text,
                            onSaved: (input) => _username = input,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter a valid text!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12),
                          Container(
                            decoration: decoration,
                            margin: EdgeInsets.symmetric(horizontal: 30.0),
                            child: FormField<String>(validator: (value) {
                              if (_country == 'Country') {
                                return "Required field!";
                              } else {
                                // print(value);
                                return null;
                              }
                            }, builder: (
                              FormFieldState<String> state,
                            ) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 2.0),
                                child: Center(
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 18.0),
                                    focusNode: new AlwaysDisabledFocusNode(),
                                    decoration: InputDecoration(
                                      hintText: _country ?? 'Country',
                                      errorText: state.hasError
                                          ? state.errorText
                                          : null,
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    enableInteractiveSelection: false,
                                    onTap: Platform.isIOS
                                        ? _openCupertinoCountryPicker
                                        : _openCountryPickerDialog,
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 12.0),
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
                            onSaved: (input) => _password = input,
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
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    style: TextStyle(
                                      fontFamily: 'SFUIDisplay',
                                      fontSize: 16,
                                      color: white,
                                    ),
                                    text: "By registering you accept our ",
                                  ),
                                  TextSpan(
                                    recognizer: null,
                                    style: TextStyle(
                                      fontFamily: 'SFUIDisplay',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: secondary,
                                    ),
                                    text: "Terms & Conditions",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8.0),
                            child: Button(
                              onPressed: () {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  AuthService.signUpUser(
                                      widget.model,
                                      context,
                                      _country,
                                      _email,
                                      _username,
                                      _password,
                                      _isCode,
                                      _authh);
                                }
                              },
                              label: 'REGISTER',
                              color: secondary,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Existing account?",
                                      style: TextStyle(
                                        fontFamily: 'SFUIDisplay',
                                        color: white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "  Login",
                                      style: TextStyle(
                                        fontFamily: 'SFUIDisplay',
                                        fontWeight: FontWeight.bold,
                                        color: secondary,
                                        fontSize: 15,
                                      ),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () => Navigator.pop(context),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
