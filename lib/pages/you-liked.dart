import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/global/contanst.dart';
import 'package:dating/global/data.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class YouLiked extends StatefulWidget {
      final MainModel model;
      final String value;
      final String uid;

   YouLiked({
      this.model,this.value, this.uid
  });
  @override
  _YouLikedState createState() => _YouLikedState();
}

class _YouLikedState extends State<YouLiked> {
     @override
   void initState() {
    getData();
    super.initState();
  }
  

//      List<String> lst= new List();
//   void _getAll() async {
//  lst.add('8EOG5sCr3eT9CC2vpM0d6QhtnHV2');
//   }
  static final _firestore = Firestore.instance;
  getData(){
  //   print('mnbvn');
  //       List<String> lst= new List();
  //       lst.add('8EOG5sCr3eT9CC2vpM0d6QhtnHV2');
  // _firestore.collection('/likes').document('8EOG5scCr3fdegT9CC2vpM0d6QhtnHV2').setData({
  //         'id': 'fghj',
  //         'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
  //         'friendsName': 'username',
  //         'friendsId': 'hgjkbvnm',
  //         'userName': 'username',
  //         'userId': 'vbnm',
  //         'list': lst,
  //       });
  //         print('mnb........vn');
  //   List<Stream<QuerySnapshot>> streams =[];
  //    final ab= Firestore.instance.collection('likes');
  //   //  var cd =ab.where('field', isEqualTo:'jjj').snapshots();
  //      var first =ab.where('userId', isEqualTo:'jjj').snapshots();
  //        var second =ab.where('friendId', isEqualTo:'').snapshots();

  //        streams.add(first);
  //        streams.add(second);

  //        Stream<QuerySnapshot>result=StreamGroup.merge(streams);
  //        return result;
  }

  var photo, photoId;

  gg(String a){
    print(a);
    return a;
  }
  @override
  Widget build(BuildContext context) {
//      List<String> lst= new List();
// lst.add('8EOG5sCr3eT9CC2vpM0d6QhtnHV2');
// // print(lst);
// // lst.add('B');
// // lst.add('C');
            return StreamBuilder(
                stream: Firestore.instance.collection("likes").where('list', arrayContains: widget.uid).snapshots(),
                
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return Center(
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
                          Text('Please wait...')
                        ],
                      ),
                    );
                  } else if (snapshot2.data.documents != null) {
                   
    return Container(
      child: ListView.builder(
        itemCount: snapshot2.data.documents.length,
        primary: false,
        itemBuilder: (BuildContext context, index) {

          Firestore.instance.collection('users').where('id', isEqualTo: snapshot2.data.documents[index]['userId'])
          .snapshots().listen(
                (data) {
                  data.documents.forEach((values) {
             print(values["photoUrl"]);
          });
                }
          );

          return Container(
              child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          leading: CircleAvatar(
              radius: 28,
              backgroundColor: black12,
              backgroundImage: AssetImage(slideList[index]["image"]),
          ),
          title: Text(gg(snapshot2.data.documents[index]['userId'])),
          subtitle: Container(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: grey,
                  ),
                  children: [
                    TextSpan(text: 'Compatibility:'),
                    TextSpan(text: slideList[index]["compatible"]),
                  ],
                ),
              ),
          ),
          trailing: Icon(Icons.favorite, color: red),
        ));
        },
      ),
    );
               }
                  return Center(
                    child: Text('No internet connection'),
                  );
                }
              );
          
          }
          // )
//   }
} 




//       body: StreamBuilder(
//           stream: Firestore.instance.collection("/groups").snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot1) {
//             return StreamBuilder(
//               stream: Firestore.instance.collection("/users").snapshots(),
//               builder:
//                   (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
//                 if (snapshot1.connectionState == ConnectionState.waiting ||
//                     snapshot2.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         CupertinoActivityIndicator(
//                           radius: 15,
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text('Please wait...')
//                       ],
//                     ),
//                   );
//                 } else if (snapshot1.data != null &&
//                     snapshot2.data.documents != null) {
//                   users = snapshot2.data.documents[0]['username'];
//                   print(users);
//                   return ListView(
//                     children: [
//                       ListView.builder(
//                         primary: false,
//                         shrinkWrap: true,
//                         itemCount: snapshot2.data.documents.length,
//                         itemBuilder: (BuildContext context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               //return Navigator.pushNamed(context, "/singleChat");
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Chat(
//                                             details:
//                                                 snapshot2.data.documents[index],
//                                             peerId: snapshot2.data
//                                                 .documents[index].data['id'],
//                                             peerAvatar: snapshot2
//                                                 .data
//                                                 .documents[index]
//                                                 .data['photoUrl'],
//                                           )));
//                             },
//                             child: snapshot2.data.documents[index].data['id'] ==
//                                     uid
//                                 ? Container(
//                                     height: 0,
//                                     width: 0,
//                                   )
//                                 : Card(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     elevation: 4,
//                                     margin: EdgeInsets.symmetric(
//                                         horizontal: 16, vertical: 4),
//                                     child: ListTile(
//                                       dense: true,
//                                       leading: Stack(
//                                         children: <Widget>[
//                                           CircleAvatar(
//                                             backgroundColor: black12,
//                                             backgroundImage: NetworkImage(
//                                                 snapshot2.data.documents[index]
//                                                     ["photoUrl"]),
//                                           ),
//                                           Positioned(
//                                             right: 2,
//                                             child: CircleAvatar(
//                                               radius: 5,
//                                               backgroundColor: snapshot2
//                                                           .data
//                                                           .documents[index]
//                                                               ["status"]
//                                                           .toString() ==
//                                                       "false"
//                                                   ? Colors.black
//                                                   : Colors.green,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       title: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Expanded(
//                                             child: Text(
//                                               snapshot2.data.documents[index]
//                                                   ["username"],
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                           Text(
//                                             _time,
//                                             style: TextStyle(
//                                                 color: grey, fontSize: 12),
//                                           ),
//                                         ],
//                                       ),
//                                       subtitle: Row(
//                                         children: <Widget>[
//                                           Expanded(
//                                             child: Text(
//                                               'Jennifer Lawrence Jennifer Lawrence Jennifer Lawrence',
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                           Container(
//                                             decoration: BoxDecoration(
//                                               shape: BoxShape.circle,
//                                             ),
//                                             padding: EdgeInsets.all(6),
//                                             child: Text(
//                                               '100',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 fontSize: 8,
//                                                 color: white,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                           );
//                         },
//                       ),

// // <<<<<<< dev
//                      snapshot1.data['groups'] == null ? Container() : ListView.builder(
//                           itemCount: snapshot1.data['groups'].length,
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             int reqIndex =
//                                 snapshot1.data['groups'].length - index - 1;
//                             return  GroupTile(
//                                 userName: snapshot1.data['username'],
//                                 // groupId: _destructureId(
//                                 //     snapshot1.data['groups'][reqIndex]),


// // =======
// //                       ListView.builder(
// //                           itemCount: snapshot1.data.documents.length,
// //                           shrinkWrap: true,
// //                           itemBuilder: (context, index) {
// //                             return snapshot1.data.documents == null
// //                                 ? Container(
// //                               height: 0,
// //                               width: 0,
// //                             )
// //                                 : GroupTile(

// //                                 adminName: snapshot1.data.documents[index]["admin"],
// //                                 groupIcon: snapshot1.data.documents[index]["groupIcon"].toString(),
// //                                 userName: users,
// //                                 groupId: snapshot1.data.documents[index]['groupId'],
// // >>>>>>> master
//                                 groupName: _destructureName(
//                                     snapshot1.data.documents[index]['groupName']));
//                           })
// //                      ListView.builder(
// //                          itemCount: snapshot1.data.documents.length,
// //                          shrinkWrap: true,
// //                          itemBuilder: (context, index) {
// //                            int reqIndex =
// //                                snapshot1.data.documents[index]['groupName'].length - index - 1;
// //                            return snapshot1.data.documents == null
// //                                ? Container(
// //                              height: 0,
// //                              width: 0,
// //                            )
// //                                : GroupTile(
// //                                groupIcon: snapshot1.data.documents[index]["groupIcon"].toString(),
// //                                userName: users,
// //                                groupId: snapshot1.data.documents[index]['groupId'],
// //                                groupName: _destructureName(
// //                                    snapshot1.data.documents[index]['groupName']));
// //                          })
//                     ],
//                   );
//                 }
//                 return Center(
//                   child: Text('No internet connection'),
//                 );
//               },
//             );
//           }),