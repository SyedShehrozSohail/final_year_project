import 'package:flutter/material.dart';
import '../models/history_model.dart';

class OrderScreen extends StatefulWidget {
  @override
  OrderScreenState createState() {
    return new OrderScreenState();
  }
}

class OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
          ),
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  dummyData[i].message,
                  style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),

                new Text(
                  dummyData[i].id,
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
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
