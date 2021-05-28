import 'package:dating/global/contanst.dart';
import 'package:dating/global/data.dart';
import 'package:dating/widgets/texttile.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: true,
            pinned: true,
            snap: false,
            title: Text('Artifat'),
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
              children: [
                Image.asset(
                  "assets/images/people.jpg",
                  width: width(context),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Container(
                    child: TextTile(
                      text: 'Join Group',
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: secondary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            )),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeOutQuint,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: secondary),
                            child: Center(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white24,
                                foregroundColor: white,
                                child: Icon(Icons.add),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: <Widget>[
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeOutQuint,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage(group[index]['image']),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10.0, bottom: 8, top: 8),
                                  decoration: BoxDecoration(
                                      color: black45.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Row(
                                    mainAxisAlignment: mspacebetween,
                                    children: <Widget>[
                                      Container(
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: white.withOpacity(0.8),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'SFUIDisplay',
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: group[index]
                                                          ['name'] +
                                                      ', '),
                                              TextSpan(
                                                  text: group[index]
                                                      ['age']),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          height: 20,
                                          width: 20,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Image.asset(
                                            'assets/flags/us.png',
                                            fit: BoxFit.cover,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
