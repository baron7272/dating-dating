import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/auth/login.dart';
import 'package:dating/auth/register.dart';
import 'package:dating/auth/verify.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/model/user.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/tabs/main-tabs.dart';
import 'package:dating/utils/config-utils.dart';
import 'package:dating/utils/network-utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final _firestore = Firestore.instance;
   static final _auth = FirebaseAuth.instance;


  static void signUpUser(
      MainModel model,
      BuildContext context,
      String country,
      String useremail,
      String username,
      String password,
      String isCode,
      dynamic _authh) async {
    try {
      await _firestore
          .collection('/users')
          .where('username', isEqualTo: username)
          .getDocuments()
          .then((event) {
        if (event.documents.isNotEmpty) {
          Flushbar(
            backgroundColor: primary,
            title: "Sign Up",
            message: 'Username exist',
            duration: Duration(seconds: 5),
          )..show(context);
        }
      }).catchError((e) => print("error fetching data: $e"));

      AuthResult authResult = await _authh.createUserWithEmailAndPassword(
        email: useremail.toString(),
        password: password.toString(),
      );
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore.collection('/users').document(signedInUser.uid).setData({
          'email': useremail,
          // 'password': password,
          'id': signedInUser.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'username': username,
          'photoUrl': '',
          'status': 'true',
          'password':password,
          'about': '',
          'age': '',
          'childrenAge': '',
          'club': '',
          'color': '',
          'country': country,
          'deletedAt': '',
          'drink': '',
          'education': '',
          'smoke': '',
          'type': 'Single',
          'religion': '',
          'relationshipType': '',
          'politics': '',
          'pets': '',
          'occupation': '',
          'location': '',
          'isCode': isCode,
          'kids': '',
          'horoscope': '',
          'gender': '',
          'verified': '',
          'groups': [],
          'friendsList': [],
        });
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
                ));
        Flushbar(
          backgroundColor: Colors.black,
          title: "Sign Up",
          message: "Registering user details, please wait...",
          duration: Duration(seconds: 5),
        )..show(context).whenComplete(() async {
            Map<String, dynamic> _userData = {
              'password': password.toString(),
              'username': username.toString(),
              'country': country.toString(),
              'isCode': isCode.toString(),
              'email': useremail.toString(),
              'firebaseId':signedInUser.uid,
            };
            NetworkUtils.loadingData(context);
// print(_userData);
            try {
              // print('............register.....................');
              final regUrl = '${ConfigUtils.getAPI()}/auth/register';
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
                      'datingToken', result['userDetails']['token']);

                  User __user = model.setUser(result['userDetails']['user']);
                  _prefs.setString('datingUser', json.encode(__user.toMap()));
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Verify(
                            result: result, model: model, source: 'register');
                      },
                    ),
                  );
                } else {
                  Navigator.of(context).pop();
                  Flushbar(
                    backgroundColor: primary,
                    title: "Sign Up",
                    message: 'Network failed',
                    duration: Duration(seconds: 5),
                  )..show(context);
                }
              });
            } catch (e) {
              Navigator.of(context).pop();
              Flushbar(
                backgroundColor: primary,
                title: "Sign Up",
                message: 'Network failed',
                duration: Duration(seconds: 5),
              )..show(context);
            }
            Navigator.of(context).pop();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainTabs()));
          });
      } else {}
    } catch (e) {
      print(e);
      String exception = AuthService.getExceptionText(e);
      Flushbar(
        backgroundColor: Colors.black,
        title: "Sign Up Error",
        message: exception,
        duration: Duration(seconds: 5),
      )..show(context).whenComplete(() => Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => Register())));
    }
  }

  static void logout(BuildContext context) async {
    Navigator.of(context).pop();
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (context) => Login()));
    // await _auth.signOut();
  }

//   static void login(BuildContext context, String email, String password) async {
  
//     try {
//       print('user logged in');

//       showDialog(
//           context: context,
//           builder: (context) => new Dialog(
//             backgroundColor: Colors.transparent,
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: Color(0xFFECF0F5),
//               ),
//               height: 100,
//               width: 20,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
// //                  CircularProgressIndicator(
// //                    backgroundColor: Colors.black,
// //                    valueColor: new AlwaysStoppedAnimation<Color>(
// //                        Colors.white),
// //                    strokeWidth: 5.0,
// //                  ),
//                   CupertinoActivityIndicator(
//                     radius: 15,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text("Please wait", textAlign: TextAlign.center,)
//                 ],
//               ),
//             ),
//           ));

//       Flushbar(
//         backgroundColor: black,
//         title: "Loggin In",
//         message: "Loggin in, please wait...",
//         duration: Duration(seconds: 5),
//       )..show(context).whenComplete(() => Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context)=>
//         MainTabs()
//         )));
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       Navigator.of(context).pop();
//       Navigator.of(context).pop();
//        print('user logged in');

//     } catch (e) {
//       print(e);
//       String exception = AuthService.getExceptionText(e);
//       Flushbar(
//         backgroundColor: black,
//         title: "Sign In Error",
//         message: exception,
//         duration: Duration(seconds: 5),
//       )..show(context)
//           .whenComplete(() => Navigator.of(context, rootNavigator: true).pop());
//     }
//   }

  static Future<void> forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'The password is invalid or the user does not have a password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        case 'The email address is badly formatted.':
          return 'Invalid email address.';
          break;

        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}

//final FirebaseAuth _auth = FirebaseAuth.instance;
//final GoogleSignIn googleSignIn = GoogleSignIn();
//
//String name;
//String email;
//String imageUrl;
//
//Future<String> signInWithGoogle(BuildContext context) async {
//  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//  final GoogleSignInAuthentication googleSignInAuthentication =
//  await googleSignInAccount.authentication;
//
//  final AuthCredential credential = GoogleAuthProvider.getCredential(
//    accessToken: googleSignInAuthentication.accessToken,
//    idToken: googleSignInAuthentication.idToken,
//  );
//
//  final AuthResult authResult = await _auth.signInWithCredential(credential);
//  final FirebaseUser user = authResult.user;
//
//  // Checking if email and name is null
//  assert(user.email != null);
//  assert(user.displayName != null);
//  assert(user.photoUrl != null);
//
//  name = user.displayName;
//  email = user.email;
//  imageUrl = user.photoUrl;
//
//  final _firestore = Firestore.instance;
//  FirebaseUser signedInUser = authResult.user;
//  _firestore.collection('/vixualfind_users').document(signedInUser.uid).setData({
//    'Name': name,
//    'E-mail Address': email,
//    'profilePicture': imageUrl
//  });
//
//
//  assert(!user.isAnonymous);
//  assert(await user.getIdToken() != null);
//
//  final FirebaseUser currentUser = await _auth.currentUser();
//  assert(user.uid == currentUser.uid);
//
//  return 'signInWithGoogle succeeded: $user';
//}
//
//Future<List<dynamic>> getWishList() async{
//  List<dynamic> wishList = [];
//
//  try {
//    final _firestore = Firestore.instance;
//    final FirebaseUser currentUser = await _auth.currentUser();
//    DocumentSnapshot ds = await _firestore.collection('/vixualfind_users').document(currentUser.uid).get();
//    wishList = ds.data["wishList"] ?? [];
//  }catch(e){
//
//  }
//  return wishList;
//}
