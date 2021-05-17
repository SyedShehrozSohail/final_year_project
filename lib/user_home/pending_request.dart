import 'package:flutter/material.dart';
import '../models/pending_model.dart';

class PendingScreen extends StatefulWidget {
  @override
  PendingScreenState createState() {
    return new PendingScreenState();
  }
}

class PendingScreenState extends State<PendingScreen> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 24.0,
          ),
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: new Text(
                    dummyData[i].message,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14,),
                  ),
                ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                dummyData[i].time,
                style: new TextStyle(color: Colors.red, fontSize: 12.0,),
              ),

            ),
          )
        ],
      ),
    );
  }
}

