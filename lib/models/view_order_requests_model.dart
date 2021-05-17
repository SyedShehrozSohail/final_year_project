import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderRequestModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserOrderRequestModel(),
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class UserOrderRequestModel extends StatefulWidget {
  @override
  _UserOrderRequestModelState createState() {
    return _UserOrderRequestModelState();
  }
}

class _UserOrderRequestModelState extends State<UserOrderRequestModel> {
  String getTimeDifferenceFromNow(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inSeconds < 5) {
      return "Just now";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds}s ago";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }
//  deleteData(docId) {
//    Firestore.instance
//        .collection('order_tbl')
//        .document(docId)
//        .delete()
//        .catchError((e) {
//      print(e);
//    });
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
  Stream<QuerySnapshot> getData() async*{
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    yield* Firestore.instance.collection('order_tbl').orderBy('timestamp', descending: true).snapshots();
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 5.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final db = Firestore.instance;
    final record = Record.fromSnapshot(data);
    String _string =getTimeDifferenceFromNow(record.timestamp.toDate());
    return Padding(
      key: ValueKey(record.animal),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: new ListTile(
            title: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  "${record.quantity} kg ${record.animal} - ${record.mobile}",
                  style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                new Text(
                  _string,
                  style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ],
            ),
//            trailing: IconButton(
//              icon: Icon(Icons.cancel),
//              onPressed: () async {
//                await db
//                    .collection('order_tbl')
//                    .document(data.documentID)
////                    .document(doc.documentID)
//                    .delete();
//              },
//            ),

            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                record.address,
                style: new TextStyle(color: Colors.red, fontSize: 12.0,),
              ),
            ),
          ),
      ),
    );
  }
}

class Record {
  final String animal;
  final String mobile;
  final String quantity;
  final String address;
  final Timestamp timestamp;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['animal'] != null),
        assert(map['quantity'] != null),
        assert(map['timestamp'] != null),
        assert(map['mobile'] != null),
        assert(map['address'] != null),
        animal = map['animal'],
        address = map['address'],
        quantity = map['quantity'],
        mobile = map['mobile'],
        timestamp = map['timestamp'];
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$animal:$quantity:$timestamp:$address>";
}
