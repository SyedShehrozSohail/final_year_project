import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisteredUsersList(),
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class RegisteredUsersList extends StatefulWidget {
  @override
  _RegisteredUsersListState createState() {
    return _RegisteredUsersListState();
  }
}

class _RegisteredUsersListState extends State<RegisteredUsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('butcher').snapshots(),
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

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
//        child: ListTile(
//          title: Text(
//              record.name,
//              style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//          ),
//          trailing: Text(record.phone.toString()),
//          subtitle: Text(
//              record.phone.toString(),
//              style: new TextStyle(color: Colors.red, fontSize: 12.0,),
//        ),
//          onTap: () => record.reference.updateData({'phone': FieldValue.increment(1)}),       ),
          child: new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  record.name,
                  style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),

                new Text(
                  record.mobile.toString(),
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),

              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                record.email,
                style: new TextStyle(color: Colors.red, fontSize: 12.0,),
              ),

            ),
          )

      ),
    );
  }
}

class Record {
  final String name;
  final String mobile;
  final String email;
//  final String email;
//  final int phone;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['mobile'] != null),
        assert(map['email'] != null),
        name = map['name'],
        mobile = map['mobile'],
        email = map['email'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$mobile:$email>";
}