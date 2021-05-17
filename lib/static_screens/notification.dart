import 'package:flutter/material.dart';

import '../models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  @override
  NotificationScreenState createState() {
    return new NotificationScreenState();
  }
}

class NotificationScreenState extends State<NotificationScreen> {
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

