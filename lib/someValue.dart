import 'package:flutter/material.dart';

class SomeValue extends StatefulWidget {
  @override
  _SomeValueState createState() => _SomeValueState();
}

class _SomeValueState extends State<SomeValue> {
  var someValue = 2;
  var newValue = 5;

  @override
  Widget build(BuildContext context) {
    print("build called");

    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            someValue.toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
        RaisedButton(
          child: Text("Press me"),
          onPressed: () {
            print(someValue.toString());


            setState(() {
              someValue++;
            });

            print(someValue.toString());
          },
        ),

      ],
    );
  }
}
