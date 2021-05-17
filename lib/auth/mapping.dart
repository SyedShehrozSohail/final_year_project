
import 'package:final_year_project/auth/authentication.dart';
import 'package:final_year_project/auth/login_register_page.dart';
import 'package:final_year_project/navigators/admin_panel.dart';
import 'package:final_year_project/navigators/side_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementation auth;

  MappingPage({
    this.auth,
  });
  State<StatefulWidget> createState() {
    return _MappingPageState();
  }
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  @override
  void initState() {
    super.initState();
      widget.auth.getCurrentUser().then((firebaseUserId) {
      setState(() {
        authStatus = firebaseUserId == null
            ? AuthStatus.notSignedIn
            : AuthStatus.signedIn;
      });
    });
  }


  void _signedIn() {
    setState(() {
        authStatus = AuthStatus.signedIn;
    });
  }

  void _signOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginRegisterPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );

      case AuthStatus.signedIn:
        return UserHome(
          auth: widget.auth,
          onSignedOut: _signOut,
        );
    }
    return null;
  }
}