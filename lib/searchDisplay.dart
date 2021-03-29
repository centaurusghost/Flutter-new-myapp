import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class contacts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text('Search Saved Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),

      ),

    );
  }
}