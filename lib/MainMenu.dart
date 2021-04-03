import 'package:clean_app/DataPage.dart';
import 'package:flutter/material.dart';
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
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Contact> contactList;
  int cout = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }
  void surelyDelete(BuildContext context, Contact contact ) async{
     await databaseHelper.deleteContact(contact.id);
  }

  //shows dialog before deleting
  void showDeleteDialog(BuildContext context, Contact contact) async{
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
                surelyDelete(context, contact);
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
                surelyDelete(context, contact);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //fetchContacts();
    if (contactList == null) {
      contactList = List<Contact>();
    }
    //initState();
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text('Details')),
      body: fetchContact(),

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
            // case 1:
            //   searchController.text ;
            //   break;
            // case 2:
            //   break;
          }
        },
      ),
    );
  }

  ListView fetchContact() {
    //TextStyle titleStyle = Theme.of(context).textTheme.subhead;
   return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.perm_contact_cal),
            ),
            title: Text(contactList[position].name),
            subtitle: Text(contactList[position].phone),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                showDeleteDialog(context, contactList[position]);
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
     );
  }
}
