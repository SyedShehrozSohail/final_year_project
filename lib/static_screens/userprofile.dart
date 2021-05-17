import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:final_year_project/auth/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> _actCopy(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Link Copied',style: TextStyle(fontSize: 22),),
        content: const Text('Link copied to clipboard'),
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

enum ConfirmAction { CANCEL, CONFIRM }
Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete my account ?',style: TextStyle(fontSize: 22),),
        content: const Text(
            'Are you sure you want to delete this account?'),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('CONFIRM'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CONFIRM);
            },
          )
        ],
      );
    },
  );
}

Future<String> _asyncInputDialog(BuildContext context, String s) async {
  String cellNumber = '';
  return showDialog<String>(
    context: context,
    barrierDismissible:
    false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(s),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
                  autofocus: true,
                  onChanged: (value) {
                    cellNumber = value;
                  },
                ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(cellNumber);
            },
          ),
        ],
      );
    },
  );
}

class MyAccountSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccountSetting(),

    );
  }
}

class AccountSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AccountSettings();
  }
}

class AccountSettings extends State<AccountSetting> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    initUser();
  }
  initUser() async {
    _user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          title: Text('My Profile', style: TextStyle(fontSize: 20.0)),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.red),*/
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //right left wrt second widget,,,reverse in Row
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10.0),
              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  IconButton(
//                    icon: Icon(Icons.account_circle),
//                    iconSize: 30,
//                    onPressed: () {},
//                  ),
//                  Text(
//                    "Full name",
//                    style: TextStyle(fontSize: 18),
//                  ),
//                  Container(
//                    margin: const EdgeInsets.only(left: 12.0),
//                  ),
//                  Text("Syed Shehroz Sohail",
//                      style:
//                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                  IconButton(
//                    onPressed: () async {
//                      final String currentUser =
//                      await _asyncInputDialog(context, 'Enter Name:');
//                    },
//                    icon: Icon(Icons.edit),
//                    iconSize: 20,
//                  ),
//                ],
//              ),
/*
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.phone_iphone),
                    iconSize: 30,
                    onPressed: () {},

                  ),
                  Text(
                    "Phone no",
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12.0),
                  ),
                  Text("0323-4358258",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      final String currentUser =
                      await _asyncInputDialog(context, 'Enter Phone:');
                    },
                    iconSize: 20,
                  ),
                ],
              ),
*/
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.mail),
                    iconSize: 30,
                    onPressed: () {},
                  ),
//                  Text(
//                    "Email",
//                    style: TextStyle(fontSize: 18),
//                  ),
//                  Container(
//                    margin: const EdgeInsets.only(left: 12.0),
//                  ),
                  Text(
                    _user == null ? '' : _user.email,
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      final String currentUser =
                      await _asyncInputDialog(context, 'Enter Email:');
                    },
                    iconSize: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.share),
                    iconSize: 30,
                    onPressed: () {
                      ClipboardManager.copyToClipBoard("https://play.google.com/store/app/details?id=com.qasaiwala").then((result) {
                        final snackBar = SnackBar(
                          content: Text('Link copied to Clipboard'),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      });
                    },
                  ),
                  Text(
                    "Share app with my friends",
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12.0),
                  ),
                  Text(
                    "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon:Icon(Icons.link) ,
                    onPressed: (){
                      ClipboardManager.copyToClipBoard("https://play.google.com/store/app/details?id=com.qasaiwala").then((result) {
                        final snackBar = SnackBar(
                          content: Text('Link copied to Clipboard'),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      });
                    },
                    iconSize: 24,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  Text(
                    "Delete my account",
                    style: TextStyle(
                      //   fontWeight: FontWeight.bold,
                        fontSize: 18),

                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12.0),
                  ),
                  Text(
                    "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () async {
                      final ConfirmAction action = await _asyncConfirmDialog(context);
                    },
                    iconSize: 24,

                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
