import 'dart:convert';
import 'dart:io';

import 'package:dating/utils/config-utils.dart';
import 'package:dating/utils/network-utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/pages/grid-views.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/widgets/double-column.dart';
import 'package:dating/widgets/single-row.dart';
import 'package:dating/widgets/visibility.dart';

class Profile extends StatefulWidget {
  final bool myProfile;
   final MainModel model;
   final String token;
  final Map<String, dynamic> userInfo;

  Profile({this.model,this.userInfo,this.token,
    this.myProfile = true,
  });
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String str =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has...";

         @override
   void initState() {
    _getAll();
    super.initState();
  }
  String  club,smoke,drink,pets,kids,occupation,education,horoscope,religion,color,gender,about,age,name,username;

  Map<String, dynamic> userInfo;

_getAll() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  setState(() {
     
       Map<String, dynamic> userInfo = json.decode(prefs.getString('datingUser'));
       club=userInfo['club'];
       smoke=userInfo['smoke'];
       drink=userInfo['drink'];
       pets=userInfo['pets'];
       kids=userInfo['kids'];
       occupation=userInfo['occupation'];
       education=userInfo['education'];
       horoscope=userInfo['horoscope'];
       religion=userInfo['religion'];
       color=userInfo['color'];
       gender=userInfo['gender'];
       about=userInfo['about'];
       age=userInfo['age'];
       name=userInfo['name'];
        username=userInfo['username'];
  });
}
 static final imgUrl = '${ConfigUtils.getAPI()}/updatePics';
  String __img;
    File avatarImageFile;

 Future getImage(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        avatarImageFile = image;
          NetworkUtils.loadingData(context);
      });
      uploadFile(context, avatarImageFile);
    }
  }


  uploadFile(BuildContext context, File avatarImageFile) async {
  
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String _token = prefs.getString('mhagictoken');

    // open a byteStream
    var stream =
        new http.ByteStream(DelegatingStream.typed(avatarImageFile.openRead()));
    // get file length
    var length = await avatarImageFile.length();

    // string to uri
    var uri = Uri.parse(imgUrl);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
    request.fields["id"] = 'check';

    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(avatarImageFile.path));

    Map<String, String> headers = {
      'Authorization': 'Bearer ${widget.token}',
    };

    request.headers.addAll(headers);

    // add file to multipart
    request.files.add(multipartFile);

    // send request to upload image
    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) async {
        Map<String, dynamic> result = json.decode(value);

        if (result['success'] == true) {

          print('...................');
           print(result['userDetails']);
          setState(() {
            __img = result['userDetails']['imageUrl'];
          });
        } else {
          Flushbar(
            backgroundColor: primary,
            title: "Upload error",
            message: result['error'],
            duration: Duration(seconds: 5),
          )..show(context);
        }
      });
    }).catchError((e) {
      print(e);
      Flushbar(
        backgroundColor: primary,
        title: "Upload error",
        message: 'Failed to upload image',
        duration: Duration(seconds: 5),
      )..show(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: height(context) / 1.65,
                  width: width(context),
                  child: Image.asset(
                    widget.myProfile
                        ? "assets/images/img3.jpg"
                        : "assets/images/img1.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: height(context) / 1.65,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        secondary,
                        secondary.withOpacity(0.005),
                        primary,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.clamp,
                    ),
                  ),
                ),
                Positioned(
                  top: 30.0,
                  right: 8,
                  child: widget.myProfile
                      ? IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/settings"),
                          icon: Icon(Icons.settings, color: white),
                        )
                      : Container(),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    crossAxisAlignment: cstart,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: mspacebetween,
                          children: <Widget>[
                            Text(
                           name==null?'':name +  age==null?'':age,
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0),
                            ),
                            widget.myProfile
                                ? IconButton(
                                     onPressed: () {
                                  getImage(context);
                                },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: white,
                                      size: 32,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(username==null?'':username,
                          style: TextStyle(color: white, fontSize: 18.0),
                        ),
                      ),
                      SizedBox(height: 20),
                      widget.myProfile
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 0.0),
                              child: Column(
                                crossAxisAlignment: cstart,
                                children: <Widget>[
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    'Visibility',
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: mspacebetween,
                                    children: <Widget>[
                                      Visible(),
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(
                                            context, "/upgrade"),
                                        child: Container(
                                          width: 150,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          decoration: BoxDecoration(
                                              color: secondary,
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(8.0)),
                                          child: Text(
                                            'Upgrade',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Divider(
              color: grey,
              indent: 20,
              endIndent: 20,
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 10),
                DoubleColumn(
                  title: 'About',
                  children: <Widget>[
                    Text(
                    about==null?'':about.length < 60 ? about : about.substring(0, 60),
                      style: TextStyle(color: Colors.white54, fontSize: 16.0),
                    ),
                  ],
                ),
                DoubleColumn(
                  title: "Details",
                  children: <Widget>[
                    SingleRow(
                      title: 'Gender:',
                      content: gender==null?'':gender,
                    ),
                    SizedBox(height: 8.0),
                    SingleRow(
                      title: 'Color:',
                      content: color==null?'':color,
                    ),
                    SizedBox(height: 8.0),
                    SingleRow(
                      title: 'Religion:',
                      content: religion==null?'':religion,
                    ),
                    SizedBox(height: 8.0),
                    SingleRow(
                      title: 'Horoscope:',
                      content: club==null?'':club,
                    ),
                    SizedBox(height: 8.0),
                    SingleRow(
                      title: 'Education:',
                      content:club==null?'':club,
                    ),
                    SizedBox(height: 8.0),
                    SingleRow(
                      title: 'Occupation:',
                      content: club==null?'':club,
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
                DoubleColumn(
                  title: 'Persona',
                  children: <Widget>[
                    SingleRow(
                      title: 'Kids:',
                      content: kids==null?'':kids,
                    ),
                    SizedBox(height: 8.0),
                    SingleRow(
                      title: 'Pets:',
                      content: pets==null?'':pets,
                    ),
                    SizedBox(height: 8.0),
                    SingleRow(
                      title: 'Drink:',
                      content: drink==null?'':drink,
                    ),
                    SizedBox(height: 8.0),
                    SingleRow(
                      title: 'Smoke:',
                      content: smoke==null?'':smoke,
                    ),
                    SizedBox(height: 8.0),
                    SingleRow(
                      title: 'Club:',
                      content: club==null?'':club,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(
              color: grey,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 16),
            GridViews(userInfo:widget.userInfo, model :widget.model),
          ],
        ),
      ),
    );
  }
}
