import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ApprovedBookingModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: GetBookingDataFromFireStore(),
    );
  }
}
class GetBookingDataFromFireStore extends StatelessWidget {
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('booking_tbl')
//                  .where('approve', isEqualTo: true)
                  .orderBy('timestamp',descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ListTile(
//                            onTap:() async { await db.collection('booking_tbl').document(doc.documentID).delete();},
//                            onLongPress:() async { await db.collection('booking_tbl').document(doc.documentID).delete();},
                            title: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${doc.data['animal']} - Slaughtering",
                                  style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                Text(
                                  "${doc.data['approve']}",
                                  style: new TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            subtitle: new Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: new Text("${doc.data['address']} ",
                                style: new TextStyle(color: Colors.red, fontSize: 12.0,),
                              ),
                            ),
//                            trailing: IconButton(
//                              icon: Icon(Icons.verified_user),
//                              color: Colors.green,
//                              onPressed: () async {
//                                await db.collection('booking_tbl').document(doc.documentID).updateData({'approve':true});
//                              },
//                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ],
      ),
    );
  }
}