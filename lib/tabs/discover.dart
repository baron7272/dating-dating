import 'package:dating/global/contanst.dart';
import 'package:dating/global/data.dart';
import 'package:dating/widgets/single-slide.dart';
import 'package:flutter/material.dart';

import '../widgets/info-profile.dart';
import '../pages/group-page.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  final PageController ctrl = PageController(viewportFraction: 0.8);

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      int next = ctrl.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        backgroundColor: transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/filter"),
            child: Row(children: [
              Text(
                'Match Filter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: white,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 16 ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: white,
              ),
            ]),
          ),
        ),
      ),
      body: Container(
          height: height(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[secondary, primary, primary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: ctrl,
                  itemCount: slideList.length,
                  itemBuilder: (BuildContext context, index) {
                    bool active = index == currentPage;

                    final double blur = active ? 4 : 0;
                    final double offset = active ? 4 : 0;
                    final double top = active ? 10 : 70;

                    return SingleSlide(
                      blur: blur,
                      top: top,
                      offset: offset,
                      image: slideList[index]["image"],
                      name: slideList[index]['name'],
                      age: slideList[index]["age"],
                      grouped: slideList[index]["group"],
                      singleAction: () {
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return InfoProfile();
                            },
                            fullscreenDialog: true));
                      },
                      groupAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GroupPage()),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
