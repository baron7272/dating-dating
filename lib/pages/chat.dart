import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/global/data.dart';
import 'package:dating/widgets/type-message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dating/global/contanst.dart';
import 'package:dating/widgets/bubble.dart';
import 'package:dating/widgets/texttile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _messageController = new TextEditingController();
  FocusNode _messageFocusNode = new FocusNode();
  bool _hasMessage = false;

  bool _single = false;
  bool _blocked = false;
  bool _isAdmin = true;

  File _imageFile;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _imageFile = picture;
    });
    Navigator.pop(context);
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _imageFile = picture;
    });
    Navigator.pop(context);
  }

  Future<void> _showSource(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: mspaceevenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _openCamera(context);
                  },
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        child: Icon(
                          Icons.camera_alt,
                          color: white,
                        ),
                        backgroundColor: primary,
                      ),
                      SizedBox(height: 6.0),
                      TextTile(
                        text: 'Camera',
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _openGallery(context);
                  },
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        child: Icon(
                          Icons.collections,
                          color: white,
                        ),
                        backgroundColor: secondary,
                      ),
                      SizedBox(height: 6.0),
                      TextTile(
                        text: 'Gallery',
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _messageController.addListener(_checkFocus);
    _messageFocusNode.addListener(_resetIfNull);
    super.initState();
  }

  _checkFocus() {
    if (_messageController.text != '') {
      setState(() => _hasMessage = true);
    }
  }

  _resetIfNull() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_messageFocusNode.hasFocus &&
          _messageController.text == '' &&
          _hasMessage) {
        setState(() => _hasMessage = false);
      }
    });
  }

  _hideFocus() {
    FocusScopeNode _scope = FocusScope.of(context);
    if (!_scope.hasPrimaryFocus) {
      _scope.unfocus();
    }
  }

  @override
  void dispose() {
    _messageController.removeListener(_checkFocus);
    _messageController.dispose();
    _messageFocusNode.removeListener(_resetIfNull);
    _messageFocusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: transparent,
        iconTheme: IconThemeData(
          color: black,
        ),
        title: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/img1.jpg"),
                ),
                Positioned(
                  right: 1,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'Chloe',
                style: TextStyle(color: black),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          if (_single == false)
            IconButton(
              icon: Icon(
                Icons.videocam,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: null,
            ),
          PopupMenuButton<ChatSettings>(
            onSelected: (ChatSettings result) {
              setState(() {
                // _selection = result;
              });
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<ChatSettings>>[
              const PopupMenuItem<ChatSettings>(
                value: ChatSettings.clear,
                child: Text('Clear Chat'),
              ),
              if (_single == true)
                const PopupMenuItem<ChatSettings>(
                  value: ChatSettings.block,
                  child: Text('Block user'),
                ),
              if (_single == false && _isAdmin == true)
                const PopupMenuItem<ChatSettings>(
                  value: ChatSettings.edit,
                  child: Text('Edit zoom link'),
                ),
              if (_single == false)
                const PopupMenuItem<ChatSettings>(
                  value: ChatSettings.invite,
                  child: Text('Invite a friend'),
                ),
              if (_single == false)
                const PopupMenuItem<ChatSettings>(
                  value: ChatSettings.share,
                  child: Text('Share'),
                ),
              if (_single == false)
                const PopupMenuItem<ChatSettings>(
                  value: ChatSettings.exit,
                  child: Text('Exit group'),
                ),
            ],
          )
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("contact")
            .document('10 june')
            .collection('messages')
            .getDocuments()
            .asStream(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(height: 10),
                  Text('Please, wait!!!')
                ],
              ),
            );
          }
          print(snapshot.data.documents);
          return GestureDetector(
            onTap: () => _hideFocus(),
            child: Column(
              crossAxisAlignment: cstart,
              children: <Widget>[
                SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, index) => Bubble(
                        time: DateFormat('hh:mm aa').format(DateTime.parse(
                            snapshot.data.documents[index]['time'].toDate().toString())),
                        message: snapshot.data.documents[index]['text'],
                        isMe: chatData[index]['me'],
                        isSeen: chatData[index]['seen'],
                        hasImage: chatData[index]['isImage'],
                        image: chatData[index]['image'],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Expanded(
                            child: TypeMessage(
                              controller: _messageController,
                              focusNode: _messageFocusNode,
                            ),
                          ),
                        ),
                        !_hasMessage
                            ? InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: CircleAvatar(
                                    backgroundColor: secondary,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: white,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  _showSource(context);
                                })
                            : InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: CircleAvatar(
                                    backgroundColor: secondary,
                                    child: Icon(
                                      Icons.send,
                                      color: white,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  final form = _formKey.currentState;
                                  if (form.validate()) {
                                    form.save();

                                    Firestore.instance
                                        .collection("contact")
                                        .document('10 june')
                                        .collection('messages')
                                        .add({
                                      'text': _messageController.text,
                                      'sender_id': 'sender uid',
                                      'sender_name': 'promise',
                                      'profile_photo': '',
                                      'image_url': '',
                                      'me': true,
                                      'time': FieldValue.serverTimestamp(),
                                    });
                                  }
                                  _messageController.clear();
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
