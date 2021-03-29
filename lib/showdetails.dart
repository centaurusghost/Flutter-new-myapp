 import 'package:flutter/material.dart';
 import 'dart:convert';
class NextPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<NextPage> {
 // List<Users> _users;
//bool _loading;
  TextEditingController remainingController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Users'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: FutureBuilder(builder: (context, snapshot){
          var showData = json.decode(snapshot.data.toString());
          return ListView.builder(
            itemBuilder: (BuildContext content, int index){
              return ListTile(
                title: Text(showData[index]['name']),
                subtitle: Text(showData[index]['phone']),
                );
            },
              itemCount: showData == null ? 0 : showData.length,
          );
},
          future:DefaultAssetBundle.of(context).load("assets/database.json") ),



        // body: Padding(
        //     padding: EdgeInsets.all(10),
        //     child: ListView(
        //       children: <Widget>[
        //         Container(
        //           height: 55,
        //           alignment: Alignment.center,
        //           padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        //           child: TextField(
        //             controller: totalController,
        //             style: TextStyle(
        //               fontWeight: FontWeight.w500,
        //               fontSize: 20,
        //             ),
        //            // keyboardType: TextInputType.number,
        //
        //             // obscureText: true,
        //              //controller: passwordController,
        //             decoration: InputDecoration(
        //
        //               border: OutlineInputBorder(),
        //                 //labelText:
        //               labelText: 'Name',
        //              // hintText: myController.text,
        //             ),
        //
        //           ),
        //         ),
        //         Container(
        //           height: 55,
        //           alignment: Alignment.center,
        //           padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        //           child: TextField(
        //             style: TextStyle(
        //               fontWeight: FontWeight.w500,
        //               fontSize: 20,
        //             ),
        //             keyboardType: TextInputType.number,
        //             // obscureText: true,
        //             //controller: passwordController,
        //             decoration: InputDecoration(
        //               border: OutlineInputBorder(),
        //
        //               labelText: 'Phone No.',
        //             ),
        //
        //           ),
        //         ),
        //
        //         Container(
        //             height: 50,
        //             alignment: Alignment.center,
        //             padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        //             child: FlatButton(
        //               textColor: Colors.white,
        //               color: Colors.blue,
        //               child: Text('Save'),
        //               onPressed: () {
        //
        //                 // print(nameController.text);
        //                 // print(passwordController.text);
        //               },
        //             )),
        //       ],
        //     )));
    ));}
}