import 'dart:io';

import 'package:dating/global/contanst.dart';
import 'package:dating/global/custom-dialog/choice-dialog.dart';
import 'package:dating/global/data.dart';
import 'package:dating/pages/contacts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'animated-button.dart';
import 'texttile.dart';

class FilterPopup extends StatefulWidget {
  final bool isSingle, newGroup;
  FilterPopup({
    this.isSingle = true,
    this.newGroup = false,
  });
  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  String _gender = 'Female';
  String _politics = 'Democrat';
  String _occupation = 'Student';
  String _color = 'Black';
  String _religion = 'Christain';
  String _zodiac = 'Pisces';
  String _relationship = 'Casual';

  File _imageFile;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _imageFile = picture;
    });
  }

  var ageRange = RangeValues(18, 100);
  var distRange = RangeValues(18, 100);

  void _selectedGender(String value) {
    print('Selected $value');
    setState(() {
      _gender = value;
      Navigator.pop(context);
    });
  }

  void _selectedPolitics(String value) {
    print('Selected $value');
    setState(() {
      _politics = value;
      Navigator.pop(context);
    });
  }

  void _selectedOccupation(String value) {
    print('Selected $value');
    setState(() {
      _occupation = value;
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
      _zodiac = value;
      Navigator.pop(context);
    });
  }

  void _selectedRelationship(String value) {
    print('Selected $value');
    setState(() {
      _relationship = value;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.newGroup ? Container() : SizedBox(height: 16),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40),
          title: Text('Gender'),
          subtitle: Text(_gender),
          onTap: _genderDialog,
        ),
        Divider(height: 0),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40),
          title: Text('Politics'),
          subtitle: Text(_politics),
          onTap: _politicsDialog,
        ),
        Divider(height: 0),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40),
          title: Text('Occupation'),
          subtitle: Text(_occupation),
          onTap: _occupationDialog,
        ),
        Divider(height: 0),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40),
          title: Text('Color'),
          subtitle: Text(_color),
          onTap: _colorDialog,
        ),
        Divider(height: 0),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40),
          title: Text('Religion'),
          subtitle: Text(_religion),
          onTap: _religionDialog,
        ),
        !widget.isSingle && widget.newGroup ? Divider(height: 0) : Container(),
        !widget.isSingle && widget.newGroup
            ? ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: grey,
                  backgroundImage: _imageFile == null
                      ? AssetImage('assets/images/img1.jpg')
                      : AssetImage(_imageFile.path),
                ),
                title: Text('Add Group Image'),
                onTap: () {
                  _openGallery(context);
                })
            : Container(),
        !widget.isSingle && widget.newGroup ? Divider(height: 0) : Container(),
        !widget.isSingle && widget.newGroup
            ? ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 40),
                title: Text('Invite Friends'),
                // subtitle: Text(_religion),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Contacts(
                        group: true,
                      ),
                    ),
                  );
                })
            : Container(),
        !widget.isSingle
            ? Container()
            : Column(
                children: <Widget>[
                  Divider(height: 0),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 40),
                    title: Text('Zodiac'),
                    subtitle: Text(_zodiac),
                    onTap: _zodiacDialog,
                  ),
                  Divider(height: 0),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 40),
                    title: Text('Relationship Type'),
                    subtitle: Text(_relationship),
                    onTap: _relationshipDialog,
                  ),
                  Divider(height: 0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: cstart,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                          child: Row(
                            children: <Widget>[
                              TextTile(
                                text: 'Age Range:',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(width: 30),
                              Row(
                                children: <Widget>[
                                  TextTile(
                                    text: "${ageRange.start.floor()}" + "yrs",
                                    fontSize: 16,
                                  ),
                                  SizedBox(width: 16),
                                  TextTile(
                                    text: '-',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(width: 16),
                                  TextTile(
                                    text: "${ageRange.end.floor()}" + "yrs",
                                    fontSize: 16,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        RangeSlider(
                          values: ageRange,
                          min: 18,
                          max: 100,
                          divisions: 30,
                          activeColor: secondary,
                          inactiveColor: secondary.withOpacity(0.2),
                          labels: RangeLabels("${ageRange.start.floor()}",
                              "${ageRange.end.floor()}"),
                          onChanged: (RangeValues newAge) {
                            print(ageRange);
                            setState(() => ageRange = newAge);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(height: 0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: cstart,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                          child: Row(
                            children: <Widget>[
                              TextTile(
                                text: 'Distance:',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(width: 30),
                              Row(
                                children: <Widget>[
                                  TextTile(
                                    text: "${distRange.start.floor()}" + "m",
                                    fontSize: 16,
                                  ),
                                  SizedBox(width: 16),
                                  TextTile(
                                    text: '-',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(width: 16),
                                  TextTile(
                                    text: "${distRange.end.floor()}" + "m",
                                    fontSize: 16,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        RangeSlider(
                          values: distRange,
                          min: 18,
                          max: 100,
                          divisions: 30,
                          activeColor: secondary,
                          inactiveColor: secondary.withOpacity(0.2),
                          labels: RangeLabels("${distRange.start.floor()}",
                              "${distRange.end.floor()}"),
                          onChanged: (RangeValues newDist) {
                            print(distRange);
                            setState(() => distRange = newDist);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        widget.newGroup
            ? Container()
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: Row(
                  mainAxisAlignment: mcenter,
                  children: [
                    Expanded(
                      child: AnimatedButton(
                        onTap: null,
                        cardColor: secondary,
                        color: secondary,
                        option: "Search",
                        height: 44,
                      ),
                    ),
                    !widget.isSingle
                        ? Expanded(
                            child: AnimatedButton(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/newGroup"),
                              cardColor: secondary,
                              color: secondary,
                              option: "New Group",
                              height: 44,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
      ],
    );
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

  _politicsDialog() {
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
            title: Text('Politics'),
            initialValue: _politics,
            items: politics,
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
            onSelected: _selectedPolitics,
          ),
        ),
      ),
    );
  }

  _occupationDialog() {
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
            title: Text('Occupation'),
            initialValue: _occupation,
            items: occupation,
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
            onSelected: _selectedOccupation,
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
            title: Text('Zodiac'),
            initialValue: _zodiac,
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

  _relationshipDialog() {
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
            title: Text('Relation Type'),
            initialValue: _relationship,
            items: relationship,
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
            onSelected: _selectedRelationship,
          ),
        ),
      ),
    );
  }
}
