import 'package:clean_app/DataPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clean_app/Contact.dart';
import 'package:clean_app/DatabaseHelper.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<MainMenu> {
  TextEditingController searchController = TextEditingController();
  int index, count = 0;
  int _cIndex = 0;
  DatabaseHelper _databaseHelper; //i am lil confused here
  List<Contact> contact;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  //shows dialog before deleting
  void showDeleteDialog(BuildContext context, int x) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!"),
          backgroundColor: Colors.white,
          content: new Text("Do you really Want to Delete?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              textColor: Colors.white,
              minWidth: 100,
              color: Colors.red,
              onPressed: () {
                _databaseHelper.deleteContact(x);
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 50),
            new FlatButton(
              child: new Text("No"),
              textColor: Colors.white,
              minWidth: 100,
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // void navigateToDataPage(Contact contact, String title){
  //   Navigator.push(context, MaterialPageRoute(builder: (context){
  //     return DataPage(contact,);
  //   }))
  // }
  @override
  Widget build(BuildContext context) {
    if (contact == null) {
      contact = List<Contact>();
    }
    //initState();
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text('Details')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z,a-z, ]')),
                    LengthLimitingTextInputFormatter(20),
                  ],
                  // controller: phoneController,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    // fillColor: Colors.white, filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Search Peoples',
                  ),
                  controller: searchController,
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: count,
                itemBuilder: (BuildContext context, int position) {
                  return Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(contact[position].name),
                      subtitle: Text(contact[position].phone),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: () {
                          showDeleteDialog(context, position);
                        },
                      ),
                      //i dont know how to pass that editmode = true or false value
                      onTap: () {
                        //Datapage void _save() it contains edit mode check look once
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DataPage()),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        onTap: (index) {
          _incrementTab(index);
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataPage()),
              );
              break;
            case 1:
              searchController.text;
              break;
            case 2:
              break;
          }
        },
      ),
    );
  }
}
