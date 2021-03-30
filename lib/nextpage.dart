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
          mainAxisSize: MainAxisSize.min,
          children: [
            // RaisedButton(child:Text("new User"),onPressed: (){
            //   Navigator.push(context,
            //     MaterialPageRoute(builder: (context)=>LoginPage(editMode: false,)),
            //   );
            // }),
            FutureBuilder(
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

          ],
        ));
  }
}
