//import 'package:flutter/material.dart';
//
//class NamedIcon extends StatelessWidget {
//  final IconData iconData;
//  final String text;
//  final VoidCallback onTap;
//  final int notificationCount;
//
//  const NamedIcon({
//    Key key,
//    this.onTap,
//    @required this.text,
//    @required this.iconData,
//    this.notificationCount,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//      onTap: onTap,
//      child: Container(
//        width: 72,
//        padding: const EdgeInsets.symmetric(horizontal: 8),
//        child: Stack(
//          alignment: Alignment.center,
//          children: [
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Icon(iconData),
//                Text(text, overflow: TextOverflow.ellipsis),
//              ],
//            ),
//            Positioned(
//              top: 0,
//              right: 0,
//              child: Container(
//                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
//                alignment: Alignment.center,
//                child: Text('$notificationCount'),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//
//
//class ShowNotifications extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: _ShowNotifications(),
//      theme: new ThemeData(
//        primarySwatch: Colors.red,
//      ),
//    );
//  }
//}
//
//
//class _ShowNotifications extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('AppBar'),
//        actions: [
//          NamedIcon(
//            text: 'Inbox',
//            iconData: Icons.notifications,
//            notificationCount: 11,
//            onTap: () {},
//          ),
//          NamedIcon(
//            text: 'Mails',
//            iconData: Icons.mail,
//            notificationCount: 1,
//            onTap: () {},
//          ),
//        ],
//      ),
//    );
//  }
//}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//
//
//class OrderRequests extends StatelessWidget {
//  final db = Firestore.instance;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: ListView(
//        children: <Widget>[
//          StreamBuilder<QuerySnapshot>(
//              stream: db.collection('order_collection').snapshots(),
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  return Column(
//                    children: snapshot.data.documents.map((doc) {
//                      return ListTile(
//                            title: new Text(
//                                  "${doc.data['animal']} meat ordered",
//                                ),
//                            trailing: IconButton(
//                              icon: Icon(Icons.done),
//                              onPressed: (){
//                                //implementation here
//                              },
//                            ),
//                      );
//                    }).toList(),
//                  );
//                } else {
//                  return SizedBox();
//                }
//              }),
//        ],
//      ),
//    );
//  }
////}
//
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//
//
//class BookingRequestModel extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: GetBookingDataFromFireStore(),
//    );
//  }
//}
//class GetBookingDataFromFireStore extends StatelessWidget {
//  final db = Firestore.instance;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: ListView(
//        padding: EdgeInsets.all(12.0),
//        children: <Widget>[
//          StreamBuilder<QuerySnapshot>(
//              stream: db.collection('booking_tbl').snapshots(),
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  return Column(
//                    children: snapshot.data.documents.map((doc) {
//                      return ListTile(
//                            title: Text("Press the button to confirm booking"),
//                            trailing: IconButton(
//                              icon: Icon(Icons.verified_user),
//                              color: Colors.green,
//                              onPressed: () async {
//                                await db.collection('booking_tbl').document(doc.documentID).updateData('approve':true);
//                              },
//                            ),
//                        ),
//                    }).toList(),
//                  );
//                } else {
//                  return SizedBox();
//                }
//              }),
//        ],
//      ),
//    );
//  }
//}