import 'package:flutter/material.dart';
import 'package:maternuncle/someValue.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    print("build called");

    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [

            SomeValue(),

            Text("hle")

          ],
        ));
  }
}
