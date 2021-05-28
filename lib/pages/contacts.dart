import 'dart:developer';

import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  final bool group;
  Contacts({this.group = false});
  @override
  _ContactsState createState() => _ContactsState();
}

class Friends {
  final int id;
  final String name;
  final String username;
  final String image;
  bool selected = false;

  Friends(
    this.id,
    this.name,
    this.username,
    this.image,
  );
}

class _ContactsState extends State<Contacts> {
  // double padValue = 0;
  // bool selected = false;

  List<Friends> friends = <Friends>[
    Friends(1, 'Roselyn', 'roseline', 'assets/images/img5.jpg'),
    Friends(2, 'Glow', 'glommy', 'assets/images/img3.jpg'),
    Friends(3, 'Brian', 'brave_man', 'assets/images/img2.jpg'),
    Friends(4, 'Janet', 'jjack', 'assets/images/img1.jpg'),
    Friends(5, 'Maven', 'maverick', 'assets/images/img5.jpg'),
    Friends(5, 'Maven', 'maverick', 'assets/images/img5.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: ListView(
        children: widget.group
            ? List.generate(
                friends.length,
                (index) => ListTile(
                  // dense: true,
                  onTap: () {
                    setState(() {
                      friends[index].selected = !friends[index].selected;

                      log(friends[index].selected.toString());
                    });
                  },
                  selected: friends[index].selected,
                  leading: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: Container(
                      width: 48,
                      height: 48,
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(friends[index].image),
                      ),
                    ),
                  ),
                  title: Text(friends[index].name),
                  subtitle: Text('@' + friends[index].username),
                  trailing: (friends[index].selected)
                      ? Icon(
                          Icons.check_box,
                          color: Colors.green,
                        )
                      : Icon(Icons.check_box_outline_blank),
                ),
              )
            : List.generate(
                friends.length,
                (index) => ListTile(
                  onTap: () => Navigator.pushNamed(context, "/chat"),
                  // selected: friends[index].selected,
                  leading: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: Container(
                      width: 48,
                      height: 48,
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(friends[index].image),
                      ),
                    ),
                  ),
                  title: Text(friends[index].name),
                  subtitle: Text('@' + friends[index].username),
                  // trailing: (friends[index].selected)
                  //     ? Icon(
                  //         Icons.check_box,
                  //         color: Colors.green,
                  //       )
                  //     : Icon(Icons.check_box_outline_blank),
                ),
              ),
      ),
    );
  }
}
