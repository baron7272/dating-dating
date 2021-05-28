
import 'package:dating/global/contanst.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class NetworkUtils {
  // static const MethodChannel platform =
  //     const MethodChannel('flutter.thisoks.com.channel/simservice');

  static logoutUser(GlobalKey<ScaffoldState> scaffoldKey,
      SharedPreferences prefs, Function doLogout,
      {bool expired = false}) async {
    try {
      prefs.clear();
    } catch (e) {
      print(e.toString());
    }
    doLogout();
    Navigator.of(scaffoldKey.currentContext)
        .pushNamedAndRemoveUntil('/Signin', (Route<dynamic> route) => false);
  }

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey,
      [String message, Color color]) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.error),
            SizedBox(width: 4.0),
            Expanded(
              child: Text(message ?? 'network error, please try again'),
            )
          ],
        ),
      ),
      backgroundColor: color ?? red,
    ));
  }

  static loadingData(BuildContext context){
    showDialog(
            context: context,
            builder: (context) => new Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFFECF0F5),
                    ),
                    height: 100,
                    width: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CupertinoActivityIndicator(
                          radius: 15,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please wait",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ));}

  static redirect(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceWebView: true,
          forceSafariVC: true,
          enableJavaScript: true,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // static showToast(GlobalKey<ScaffoldState> scaffoldKey, String message) {
  //   Alert.toast(scaffoldKey.currentContext, message,
  //       position: ToastPosition.bottom, duration: ToastDuration.long);
  // }

 


}
