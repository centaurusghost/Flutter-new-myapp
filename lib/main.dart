import "package:flutter/material.dart";
import 'Login_Screen.dart';
// import 'searchDisplay.dart';
import 'showdetails.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue), home: LoginPage(
    ));
  }
}