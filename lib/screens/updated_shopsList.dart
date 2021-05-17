import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisteredShopsList(),
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class RegisteredShopsList extends StatefulWidget {
  @override
  _RegisteredShopsListState createState() {
    return _RegisteredShopsListState();
  }
}

class _RegisteredShopsListState extends State<RegisteredShopsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('shops_tbl').snapshots(),
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
                record.address,
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
  final String address;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['mobile'] != null),
        assert(map['address'] != null),
        name = map['name'],
        mobile = map['mobile'],
        address = map['address'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$mobile:$address>";
}


class MyDeletingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google SignIn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DeleteDataFromFireStore(),
    );
  }
}
class DeleteDataFromFireStore extends StatelessWidget {
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Data from Firestore")),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('order_tbl').snapshots(),
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
                            onTap:() async { await db.collection('order_tbl').document(doc.documentID).delete();},
                            title: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${doc.data['quantity']} kg ${doc.data['animal']} - ${doc.data['mobile']}",
                                  style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                ),
//                                Text(
//                                  "${doc.data['quantity']}",
//                                  style: new TextStyle(color: Colors.grey),
//                                ),
                              ],
                            ),

                            subtitle: new Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: new Text(doc.data['user'],
                                style: new TextStyle(color: Colors.red, fontSize: 12.0,),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () async {
                                await db.collection('order_tbl').document(doc.documentID).delete();
                              },
                            ),
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
