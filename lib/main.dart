import 'dart:convert';
import 'dart:io';

import 'package:dating/global/contanst.dart';
import 'package:easy_alert/easy_alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

import 'auth/create-password.dart';
import 'auth/edit-profile.dart';
import 'auth/login.dart';
import 'auth/reset-password.dart';
import 'auth/register.dart';
import 'auth/forgot-password.dart';
import 'auth/verify.dart';
import 'pages/chat.dart';
import 'pages/contacts.dart';
import 'pages/create-group.dart';
import 'pages/filter.dart';
import 'pages/settings.dart';
import 'pages/upgrade.dart';
import 'scoped-models/main-model.dart';
import 'tabs/main-tabs.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  debugPaintSizeEnabled = false;

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('datingToken');

  bool authed = false;
  if (token != null) {
    // prefs.clear();
    authed = true;
  }

  runApp(AlertProvider(
    child: MyApp(authed,token),
    config: AlertConfig(ok: "OK", cancel: "CANCEL"),
  ));
}

class MyApp extends StatefulWidget {
  final bool authed;
  final String token;
  MyApp([this.authed, this.token]);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final MainModel _model = MainModel();
  bool _updateFound = false;
  String _fcmToken = '';
String _link;
//="https://play.google.com/store/apps/details?id=com.eloksware.mhagic";
  @override
  void initState() {
    // _initRemoteConfig();
    _initFirebaseMessaging();
    initPlatformState();
    //  _initUserValue();
    super.initState();
  }
//   String club,smoke,drink,pets,kids,occupation,education,horoscope,religion,color,gender,about,age,name,username;
//   Map<String, dynamic> userInfo;
//   _initUserValue() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   setState(() {
//      userInfo = json.decode(prefs.getString('datingUser'));
//      print(userInfo);
     
//   });
// }

  initPlatformState() async {
    Wakelock.enable();
  }

  Future<void> _iOSPermission() async {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      _firebaseMessaging.getToken().then((token) {
        setState(() => _fcmToken = token);
      });
    });
  }

  void _initFirebaseMessaging() async {
    if (Platform.isIOS) {
      _iOSPermission();
    } else {
      _firebaseMessaging.getToken().then((token) {
        setState(() => _fcmToken = token);
      });
    }
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {},
    );
  }

  void _initRemoteConfig() async {       
    
    final RemoteConfig _remoteConfig = await RemoteConfig.instance;
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();

    try {
      await _remoteConfig.fetch(expiration: Duration(hours: 6));
      await _remoteConfig.activateFetched();

      String _version = _packageInfo.version;
      String _buildNumber = _packageInfo.buildNumber;

      if (Platform.isAndroid) {
    
        int _abn =
            int.tryParse(_remoteConfig.getString('android_build_number'));
        String _abname = _remoteConfig.getString('android_build_name');
         String _androidLink = _remoteConfig.getString('android_build_link');
        if (_abn > int.tryParse(_buildNumber) && _abname != _version) {
          // show message to update app
          setState(() {
            _updateFound = true;
               _link=_androidLink;
          });
          
        }
      } else if (Platform.isIOS) {
        int _ibn = int.tryParse(_remoteConfig.getString('ios_build_number'));
        String _ibname = _remoteConfig.getString('ios_build_name');
         String _iosLink = _remoteConfig.getString('ios_build_link');
        if (_ibn > int.tryParse(_buildNumber) && _ibname != _version) {
          // show message to update app
            setState(() {
            _updateFound = true;
                _link=_iosLink;
          });
        }
      }
    } catch (e) {}
  }



  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // showSemanticsDebugger: true,
        // debugShowMaterialGrid: true,
        title: 'Dating',
        theme: ThemeData(
          primaryColor: primary,
          scaffoldBackgroundColor: white,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          cursorColor: secondary,
          textSelectionHandleColor: secondary,
          appBarTheme: AppBarTheme(elevation: 0),
        ),
        
        home:
        // widget.authed
        //       ?
        MainTabs(model: _model),
              //   : CreatePassword
              //  (
              //     model: _model,
              //   ),
              // : Login(updateFound: _updateFound,link:_link,
              //     model: _model,
              //   ),
        routes: {
          "/maintabs": (BuildContext context) => MainTabs(),
          "/filter": (BuildContext context) => Filter(),
          "/upgrade": (BuildContext context) => Upgrade(),
          "/settings": (BuildContext context) => Settings(model: _model,),
          "/register": (BuildContext context) => Register(model: _model, updateFound: _updateFound,),
          "/newGroup": (BuildContext context) => CreateGroup(),
          "/editprofile": (BuildContext context) => EditProfile( model: _model),
          "/resetpwd": (BuildContext context) => ResetPassword(model: _model),
          "/forgotPwd": (BuildContext context) => ForgotPassword(model: _model),
          "/verify": (BuildContext context) => Verify(),
          "/createPwd": (BuildContext context) => CreatePassword(model: _model),
          "/chat": (BuildContext context) => Chat(),
          "/contacts": (BuildContext context) => Contacts(),
        },
      ),
    );
  }
}
