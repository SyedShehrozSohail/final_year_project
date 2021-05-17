import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderHistoryModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserOrderHistoryModel(),
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class UserOrderHistoryModel extends StatefulWidget {
  @override
  _UserOrderHistoryModelState createState() {
    return _UserOrderHistoryModelState();
  }
}

class _UserOrderHistoryModelState extends State<UserOrderHistoryModel> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
  Stream<QuerySnapshot> getData() async*{
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    yield* Firestore.instance.collection('order_tbl')
        .where("user", isEqualTo: firebaseUser.email.toString())
        .where("approve", isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots();
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  "${record.quantity} KG ${record.animal}",
                  style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),

                new Text(
                  _string,
                  style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                ),

              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                record.timestamp.toDate().toLocal().toString(),
                style: new TextStyle(color: Colors.red, fontSize: 12.0,),
              ),

            ),
          )

      ),
    );
  }
}

class Record {
  final String animal;
  final String quantity;
  final Timestamp timestamp;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['animal'] != null),
        assert(map['quantity'] != null),
        assert(map['timestamp'] != null),
        animal = map['animal'],
        quantity = map['quantity'],
        timestamp = map['timestamp'];
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$animal:$quantity:$timestamp>";
}
