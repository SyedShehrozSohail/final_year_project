import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAccountSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.mail),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  Text(
                    _user.email,
//                    this._user?.email,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ]
        ),
      ),
    );
  }
}
