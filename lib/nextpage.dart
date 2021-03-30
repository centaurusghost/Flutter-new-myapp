import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:maternuncle/DatabaseHelper.dart';
import 'package:maternuncle/loginpage.dart';
import 'package:maternuncle/peoples.dart';

class NextPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<NextPage> {
  // List<Users> _users;
//bool _loading;
  TextEditingController remainingController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  Future<dynamic> readJson() async {
    String response =
        await '[{"name":"Bishal","phone":"123"},{"name":"Ozone","phone":"123"}]';
    response = rootBundle.loadString("assets/database.json") as String;

    return (response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Users'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Center(
              child: FutureBuilder(
                  builder: (context, snapshot) {
                    List<Peoples> peoples = snapshot.data;
                    print(peoples);
                    return ListView.builder(
                      itemBuilder: (BuildContext content, int index) {
                        return ListTile(
                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>LoginPage(editMode:true,person:peoples[index])),
                            );

                          },
                          title: Text(peoples[index].name),
                          subtitle: Text(peoples[index].phone),
                        );
                      },
                      itemCount: peoples == null ? 0 : peoples.length,
                    );
                  },
                  future: dbHelper.getPeoples()),

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
            ),
            RaisedButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=>LoginPage()),
              );
            })
          ],
        ));
  }
}
