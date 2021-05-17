import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingRequestModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserBookingRequestModel(),
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class UserBookingRequestModel extends StatefulWidget {
  @override
  _UserBookingRequestModelState createState() {
    return _UserBookingRequestModelState();
  }
}

class _UserBookingRequestModelState extends State<UserBookingRequestModel> {
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
    yield* Firestore.instance.collection('booking_tbl').orderBy('timestamp', descending: true).snapshots();
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:  getData(),
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
                  "${record.animal} - ${record.address}",
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
                record.date.toDate().toLocal().toString(),
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
  final Timestamp timestamp;
  final Timestamp date;
  final String user;
  final String mobile;
  final String address;
  final DocumentReference reference;


  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['animal'] != null),
        assert(map['date'] != null),
        assert(map['mobile'] != null),
        assert(map['address'] != null),
        assert(map['timestamp'] != null),
        assert(map['user'] != null),
        animal = map['animal'],
        mobile = map['mobile'],
        address = map['address'],
        timestamp = map['timestamp'],
        user = map['user'],
        date= map['date'];
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$animal:$date:$timestamp:$user:$mobile:$address>";
}