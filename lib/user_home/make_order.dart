import 'package:flutter/material.dart';

class MakeOrder extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}
Future<void> _actCopy(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('REQUEST SENT',style: TextStyle(fontSize: 22),),
        content: const Text('Your request has been sent for approval!'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'Meat';
  String quantity="5kg";
  @override
  Widget build(BuildContext context) {
//    return DropdownButton<String>(
//      value: dropdownValue,
//      icon: Icon(Icons.arrow_downward),
//      iconSize: 24,
//      elevation: 16,
//      style: TextStyle(color: Colors.deepPurple),
//      underline: Container(
//        height: 2,
//        color: Colors.deepPurpleAccent,
//      ),
//      onChanged: (String newValue) {
//        setState(() {
//          dropdownValue = newValue;
//        });
//      },
//      items: <String>['One', 'Two', 'Free', 'Four']
//          .map<DropdownMenuItem<String>>((String value) {
//        return DropdownMenuItem<String>(
//          value: value,
//          child: Text(value),
//        );
//      }).toList(),
//    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body:

      SingleChildScrollView(
        child: Column(
          //top to bottom
            crossAxisAlignment: CrossAxisAlignment.start,       //right left wrt second widget,,,reverse in Row
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Product Type:",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child:DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 18,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                        underline: Container(
                          height: 2,
                          color: Colors.red,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Meat', 'Fish', 'Chicken', 'Beef']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Quantity:",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child:DropdownButton<String>(
                        value: quantity,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 18,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                        underline: Container(
                          height: 2,
                          color: Colors.red,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            quantity = newValue;
                          });
                        },
                        items: <String>['5kg', '10kg', '15kg', '20kg']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                  ]
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Location:",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                  IconButton(
                        icon: Icon(Icons.location_on),
                        iconSize: 32,
                        onPressed: () {},
                      ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width:400,
                  child: RaisedButton(
                    onPressed: (){
                      _actCopy(context);
                    },
                    color: Colors.red,
                    child: Text(
                        "SUBMIT ORDER"
                    ),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                  ),
                ),
              ),

            ]
        ),
      ),
    );
  }
}