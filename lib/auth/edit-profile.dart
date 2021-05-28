import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/global/custom-dialog/choice-dialog.dart';
import 'package:dating/global/data.dart';
import 'package:dating/model/user.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/utils/config-utils.dart';
import 'package:dating/utils/network-utils.dart';
import 'package:dating/widgets/button.dart';
import 'package:dating/widgets/texttile.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  final MainModel model;
  final Map<String, dynamic> userInfo;
  final String token;
  EditProfile({this.model, this.userInfo, this.token});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static final updateUser = '${ConfigUtils.getAPI()}/updateUser';

  final _scaffoldKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  String _gender = '';
  String _color = '';
  String _religion = '';
  String _horoscope = '';
  String _kids = '';
  String _pets = '';
  String _about = '';
  
  String _education = '';
  String _occupation = '';
  String _drink = '';
  String _smoke = '';
  String _club = '';

 String _about1 = '';
  //   String _gender1 = 'Female';
  // String _color1 = '';
  // String _religion1 = '';
  // String _zodiac1 = '';
  // String _kids1 = '';
  // String _pets1 = '';
  // String _education1 = '';
  // String _occupation1= '';
  // String _drink1 = '';
  // String _smoke1 = '';
  // String _club1 = '';

  // String club,smoke,drink,pets,kids,occupation,education,horoscope,religionn,colorr,genderr,about,age,name,username;

  getCurrentUser()  {
    print(widget.userInfo);
   String  club = widget.userInfo['club'] ?? '';
   String   smoke = widget.userInfo['smoke'] ?? '';
  String    drink = widget.userInfo['drink'] ?? '';
   String   pets = widget.userInfo['pets'] ?? '';
   String   kids = widget.userInfo['kids'] ?? '';
   String   occupation = widget.userInfo['occupation'] ?? '';
   String   education = widget.userInfo['education'] ?? '';
    String  horoscope = widget.userInfo['horoscope'] ?? '';
     String  religion=widget.userInfo['religion']??'';
   String    color=widget.userInfo['color']??'';
   String    gender=widget.userInfo['gender']??'';
     String ii = widget.userInfo['about'] ?? '';
      //  _age=widget.userInfo['age'];
      //  _name=widget.userInfo['name'];
      //   username=widget.userInfo['username'];
    setState(()  {
      _club = club;
      _smoke = smoke;
      _drink =drink;
      _pets = pets;
      _kids =kids;
      _occupation =occupation;
      _education = education;
      _horoscope = horoscope;
       _religion=religion;
       _color=color;
       _gender=gender;
      _about = ii;
      //  _age=widget.userInfo['age'];
      //  _name=widget.userInfo['name'];
      //   username=widget.userInfo['username'];
    });
  }

  _authenticate(
      BuildContext context,
      String about,
      String gender,
      String color,
      String religion,
      String horoscope,
      String education,
      String pets,
      String club,
      String smoke,
      String occupation,
      String kids,
      String drink) async {
    Map<String, dynamic> _userData = {
      'about': about,
      'gender': gender,
      'color': color,
      'religion': religion,
      'horoscope': horoscope,
      'education': education,
      'pets': pets,
      'club': club,
      'smoke': smoke,
      'occupation': occupation,
      'kids': kids,
      'drink': drink,
    };
    print(_userData);
    NetworkUtils.loadingData(context);
    try {
      String url = Uri.encodeFull(updateUser);

      return await http
          .post('$url',
              headers: {
                'Authorization': 'Bearer ${widget.token}',
              },
              body: _userData)
          .then((http.Response response) async {
        Map<String, dynamic> result = json.decode(response.body);

        if (result.containsKey('success')) {
          final SharedPreferences _prefs =
              await SharedPreferences.getInstance();

          User __user = widget.model.setUser(result['userDetails']);
          _prefs.setString('datingUser', json.encode(__user.toMap()));

          setState(() {
            _about1 = result['userDetails']['about']; 
          //   _gender1= result['userDetails']['gender'];
          //   _color1= result['userDetails']['color'] ;
          //   _religion1= result['userDetails']['religion'];
          //   _zodiac1= result['userDetails']['zodiac'] ;
          //   _education1= result['userDetails']['education'];
          //   _pets1= result['userDetails']['pets'] ;
          //   _club1= result['userDetails']['club'];
          //   _smoke1= result['userDetails']['smoke'];
          //   _occupation1= result['userDetails']['occupation'];
          //   _kids1= result['userDetails']['kids'] ;
          //   _drink1= result['userDetails']['drink'] ;
          });
        

          await Firestore.instance
              .collection('users')
              .document(result['userDetails']['firebaseId'])
              .updateData({
            'about': result['userDetails']['about'] ?? '',
            'gender': result['userDetails']['gender'] ?? '',
            'color': result['userDetails']['color'] ?? '',
            'religion': result['userDetails']['religion'] ?? '',
            'horoscope': result['userDetails']['horoscope'] ?? '',
            'education': result['userDetails']['education'] ?? '',
            'pets': result['userDetails']['pets'] ?? '',
            'club': result['userDetails']['club'] ?? '',
            'smoke': result['userDetails']['smoke'] ?? '',
            'occupation': result['userDetails']['occupation'] ?? '',
            'kids': result['userDetails']['kids'] ?? '',
            'drink': result['userDetails']['drink'] ?? ''
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
          Flushbar(
            backgroundColor: Colors.black,
            title: "Edit Profile",
            message: result['error'],
            duration: Duration(seconds: 5),
          )..show(context);
        }
      });
    } catch (e) {
      Navigator.of(context).pop();
      Flushbar(
        backgroundColor: Colors.black,
        title: "Edit Profile",
        message: 'Network failed!',
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }

  @override
  void initState() {
    // print(widget.userInfo);
    getCurrentUser();
    super.initState();
  }

  void _selectedGender(String value) {
    print('Selected $value');
    setState(() {
      _gender = value;
      Navigator.pop(context);
    });
  }

  void _selectedColor(String value) {
    print('Selected $value');
    setState(() {
      _color = value;
      Navigator.pop(context);
    });
  }

  void _selectedReligion(String value) {
    print('Selected $value');
    setState(() {
      _religion = value;
      Navigator.pop(context);
    });
  }

  void _selectedZodiac(String value) {
    print('Selected $value');
    setState(() {
      _horoscope = value;
      Navigator.pop(context);
    });
  }

  void _selectedDrink(String value) {
    print('Selected $value');
    setState(() {
      _drink = value;
      Navigator.pop(context);
    });
  }

  void _selectedSmoke(String value) {
    print('Selected $value');
    setState(() {
      _smoke = value;
      Navigator.pop(context);
    });
  }

  void _selectedClub(String value) {
    print('Selected $value');
    setState(() {
      _club = value;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {

     return WillPopScope(
  onWillPop: () {
  //   print('Backbutton pressed (device or appbar button), do whatever you want.');
  // // },
  //   //trigger leaving and use own data
  //   // Navigator.pop(context, false);
    Navigator.pushNamed(context, "/settings");

    //we need to return a future
    return Future.value(false);
  },
    child: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Edit Profile'),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    initialValue:_about1 != ''?_about1: _about,
                    maxLength: 80,
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: 'About Me',
                        border: OutlineInputBorder(),
                        isDense: true),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Required field';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _about = value;
                    },
                  ),
                ),
                SizedBox(height: 14.0),
                // ******Details******
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: cstart,
                    children: <Widget>[
                      TextTile(
                        text: 'Details',
                        color: primary.withOpacity(0.7),
                        fontSize: 18,
                      ),
                      SizedBox(height: 14.0),
                      GestureDetector(
                        onTap: _genderDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Gender",
                            hintStyle: TextStyle(color: black),
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          child: Text(  _gender == '' ? 'Female' : _gender,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: _colorDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Color",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          child: Text(
                            _color == '' ? 'Race' : _color,
                            style: TextStyle(
                                fontSize: 16,
                                color: _color == '' ? grey : black),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: _religionDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Religion",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          child: Text(
                          _religion == '' ? 'e.g. Christain' : _religion,
                            style: TextStyle(
                                fontSize: 16,
                                color: _religion == '' ? grey : black),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: _zodiacDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Horoscope",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          child: Text(
                           _horoscope == '' ? 'Zodiac sign' : _horoscope,
                            style: TextStyle(
                                fontSize: 16,
                                color: _horoscope == '' ? grey : black),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.0),
                      TextFormField(
                        initialValue:  _education == ''
                            ? 'e.g. Msc. Infotech'
                            : _education,
                        style:
                            TextStyle(color: _education == '' ? grey : black),
                        decoration: InputDecoration(
                            labelText: 'Education',
                            border: OutlineInputBorder(),
                            isDense: true),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _education = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        style:
                            TextStyle(color: _occupation == '' ? grey : black),
                        initialValue:  _occupation == ''
                            ? 'e.g. Computer Analyst'
                            : _occupation,
                        decoration: InputDecoration(
                            labelText: 'Occupation',
                            border: OutlineInputBorder(),
                            isDense: true),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _occupation = value;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                //****** Persona ******/
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: cstart,
                    children: <Widget>[
                      TextTile(
                        text: 'Persona',
                        color: primary.withOpacity(0.7),
                        fontSize: 18,
                      ),
                      SizedBox(height: 14.0),
                      TextFormField(
                        initialValue:  _kids == '' ? 'e.g. 5, 12' : _kids,
                        style: TextStyle(color: _kids == '' ? grey : black),
                        decoration: InputDecoration(
                            labelText: "Children's age",
                            border: OutlineInputBorder(),
                            isDense: true),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _kids = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue:  _pets == '' ? 'e.g. Dog, Cat' : _pets,
                        style: TextStyle(color: _pets == '' ? grey : black),
                        decoration: InputDecoration(
                            labelText: 'Pets',
                            border: OutlineInputBorder(),
                            isDense: true),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Required field';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _pets = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: _drinkDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Drink",
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _drink == '' ? 'Level of drinking?' : _drink,
                            style: TextStyle(
                                fontSize: 16,
                                color: _drink == '' ? grey : black),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: _smokeDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Smoke",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          child: Text(
                            _smoke == '' ? 'Level of smoking' : _smoke,
                            style: TextStyle(
                                fontSize: 16,
                                color: _smoke == '' ? grey : black),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: _clubDialog,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Club",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          child: Text(
                           _club == '' ? 'Level of clubbing' : _club,
                            style: TextStyle(
                                fontSize: 16,
                                color: _club == '' ? grey : black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Button(
                    label: 'Save',
                    radius: 4,
                    color: secondary,
                    onPressed: () {
                      print('fghjhgf');
                      final form = _formKey.currentState;
                      print('fghjhfghjgf');
                      // if (form.validate()) {
                      form.save();
                      print('fghoiuyhgujhguhgujhgf');
                      _authenticate(
                          context,
                          _about,
                          _gender,
                          _color,
                          _religion,
                          _horoscope,
                          _education,
                          _pets,
                          _club,
                          _smoke,
                          _occupation,
                          _kids,
                          _drink);
                      // }
                    },
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _genderDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) =>
          NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          child: ChoiceDialogs<String>(
            title: Text('Gender'),
            initialValue: _gender,
            items: gender,
            activeColor: secondary,
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 14, top: 10, left: 10, right: 18),
                  child: Text('Cancel'),
                ),
              )
            ],
            onSelected: _selectedGender,
          ),
        ),
      ),
    );
  }

  _colorDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) =>
          NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          child: ChoiceDialogs<String>(
            title: Text('Color'),
            initialValue: _color,
            items: color,
            activeColor: secondary,
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 14, top: 10, left: 10, right: 18),
                  child: Text('Cancel'),
                ),
              )
            ],
            onSelected: _selectedColor,
          ),
        ),
      ),
    );
  }

  _religionDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) =>
          NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          child: ChoiceDialogs<String>(
            title: Text('Religion'),
            initialValue: _religion,
            items: religion,
            activeColor: secondary,
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 14, top: 10, left: 10, right: 18),
                  child: Text('Cancel'),
                ),
              )
            ],
            onSelected: _selectedReligion,
          ),
        ),
      ),
    );
  }

  _zodiacDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) =>
          NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          child: ChoiceDialogs<String>(
            title: Text('Horoscope'),
            initialValue: _horoscope,
            items: zodiac,
            activeColor: secondary,
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 14, top: 10, left: 10, right: 18),
                  child: Text('Cancel'),
                ),
              )
            ],
            onSelected: _selectedZodiac,
          ),
        ),
      ),
    );
  }

  _drinkDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) =>
          NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          child: ChoiceDialogs<String>(
            title: Text('Drink'),
            initialValue: _drink,
            items: level,
            activeColor: secondary,
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 14, top: 10, left: 10, right: 18),
                  child: Text('Cancel'),
                ),
              )
            ],
            onSelected: _selectedDrink,
          ),
        ),
      ),
    );
  }

  _smokeDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) =>
          NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          child: ChoiceDialogs<String>(
            title: Text('Smoke'),
            initialValue: _smoke,
            items: level,
            activeColor: secondary,
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 14, top: 10, left: 10, right: 18),
                  child: Text('Cancel'),
                ),
              )
            ],
            onSelected: _selectedSmoke,
          ),
        ),
      ),
    );
  }

  _clubDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) =>
          NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          child: ChoiceDialogs<String>(
            title: Text('Club'),
            initialValue: _club,
            items: level,
            activeColor: secondary,
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 14, top: 10, left: 10, right: 18),
                  child: Text('Cancel'),
                ),
              )
            ],
            onSelected: _selectedClub,
          ),
        ),
      ),
    );
  }
}
