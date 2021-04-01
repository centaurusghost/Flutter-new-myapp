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
   //int counter = 0;
   //Contact _contact = Contact();
  // List<Contact> _contacts = [];
  // DatabaseHelper _dbHelper;
  final _formKey = GlobalKey<FormState>();
  @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     _dbHelper = DatabaseHelper.instance;
  //   });
  //   _refreshContactList();
  // }
  Widget build(BuildContext context) {
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
              Container(
                child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text('ozone'
                              //  _contacts[index].name.toUpperCase(),
                            ),
                            subtitle: Text( 'wagle'
                               // _contacts[index].phone.toUpperCase(),
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DataPage()),
                              );

                            },
                          ),
                        ],
                      );
                    }

                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 487),
                child: Container(
                  alignment: Alignment.center,
                child: Row(
                  children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DataPage()),
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                          Text('New'),
                        ],
                      ),


                      SizedBox(width: 95),

          Column(
            children: [  IconButton(
                        onPressed: () {
                          setState(() {
                           // searchController
                          });

                        },
                        icon: const Icon(Icons.search),
                      ),
              Text('Search'),


                      ]),
                      SizedBox(width: 90),
                    Column(
                        children: [  IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu),
                        ),
                          Text('Menu'),

                        ]),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),




      ),
    );
  }

}
