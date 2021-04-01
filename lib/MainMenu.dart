import 'package:clean_app/DataPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clean_app/Contact.dart';
import 'DatabaseHelper.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<MainMenu> {
  TextEditingController searchController = TextEditingController();
  int index;
  int i;
  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }
  // int counter = 0;
  List<Contact> _contacts = [];
  Contact _contact = Contact();
  // DatabaseHelper _dbHelper;
  // final _formKey = GlobalKey<FormState>();
  @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     _dbHelper = DatabaseHelper.instance;
  //   });
  //   _refreshContactList();
  // }
  Widget build(BuildContext context) {
    //initState();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
          centerTitle: true, backgroundColor: Colors.red, title: Text('Details')),
      body:
     Padding(
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

             Column(
               children: [
                 ListTile(
                     title: Text(_contacts[0].name.toUpperCase())
                //    //index to pass by making item builder but confused
                //    leading: Icon(Icons.perm_contact_cal_outlined,
                //    size: 30,),
                // title: Text(_contacts[i].name.toUpperCase()
                // ),
                //    subtitle: Text(_contacts[i].phone),
                //    trailing: Icon(Icons.delete),
                //    onTap: (){},

                 ),
               ],
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
                label: 'New',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'New',
              ),

            ],
          onTap: (index){
            _incrementTab(index);
            switch(index){
              case 0: Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataPage()),
              );
                 break;
              case 1: break;
              case 2: break;

            }
          },
          ),


    );
  }

}

