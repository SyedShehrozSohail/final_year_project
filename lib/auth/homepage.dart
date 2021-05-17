
import 'package:final_year_project/auth/authentication.dart';
import 'package:final_year_project/auth/mapping.dart';
import 'package:flutter/material.dart';

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MappingPage(
        auth: Auth(),
      ),
    );
  }
}
