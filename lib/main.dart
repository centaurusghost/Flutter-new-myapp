import "package:flutter/material.dart";
import 'loginpage.dart';

// import 'searchDisplay.dart';
import 'home.dart';
import 'nextpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: NextPage());
  }
}
