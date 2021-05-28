import 'package:dating/global/contanst.dart';
import 'package:dating/widgets/animated-button.dart';
import 'package:dating/widgets/custom-formfield.dart';
import 'package:dating/widgets/filter-popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();
  bool _private = false;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Create Group'),
          ),
          body: ListView(
            children: [
              MergeSemantics(
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 40),
                  title: Text('Private'),
                  trailing: CupertinoSwitch(
                    value: _private,
                    activeColor: secondary.withOpacity(0.4),
                    onChanged: (bool value) {
                      setState(() {
                        _private = value;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _private = !_private;
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              Divider(height: 0),
              SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CustomFormField(
                      labelText: "Group name",
                      margin: EdgeInsets.symmetric(horizontal: 24),
                    ),
                    SizedBox(height: 8),
                    Divider(height: 0),
                    SizedBox(height: 8),
                    CustomFormField(
                      labelText: "Zoom link",
                      margin: EdgeInsets.symmetric(horizontal: 24),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(height: 0),
              FilterPopup(
                isSingle: false,
                newGroup: true,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: AnimatedButton(
                  onTap: null,
                  cardColor: secondary,
                  color: secondary,
                  option: "Create",
                  width: width(context),
                  height: 46,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
