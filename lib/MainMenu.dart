import 'package:clean_app/DataPage.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/Contact.dart';
import 'package:clean_app/DatabaseHelper.dart';
import 'package:flutter/services.dart';

class MainMenu extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<MainMenu> {
  TextEditingController searchController = TextEditingController();
  String userSearchInput = "";
//search data from database
  int index;
  int _cIndex = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Contact> contacts;
  int cout = 0;
  FocusNode myFocusNode;
  List <Contact> listContact ;
  List <Contact> filteredContact;
  bool isSearching = false;


  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  void surelyDelete(BuildContext context, Contact contact) async {
    await databaseHelper.deleteContact(contact.id);
    setState((){});
  }
  //
  getContactList() async{
    var databaseFetch = await databaseHelper.fetchContact();
    return databaseFetch;
  }

  void initState() {
    super.initState();
getContactList().then((data) {
  setState(() {
    listContact = filteredContact= data;
  });
});
  if(myFocusNode==null){
    myFocusNode = FocusNode();}

  }
 void filterContact(value){
    //print(listContact.where((xxx) => xxx.name=='tilak').toList(););
   setState(() {
     filteredContact = listContact.where((contact) => contact.name.toLowerCase().contains(value.toLowerCase())).toList();
    // filteredContact = listContact.where((xxx) => xxx.name=='tilak khatri').toList();
   });
    }
  void dispose() {
  //  searchController.removeListener(onSearchChanged);
    searchController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  onSearchChanged(){
    print(searchController.text);
  }

// void searchQuery(String userInput){
  //       userInput = searchController.text;
  //       if(userInput.isEmpty){
  //         return;
  //       }else{
  //         userSearchInput = userInput;
  //       }
  // }









  //shows dialog before deleting
  void showDeleteDialog(BuildContext context, Contact contact) async {
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
  //bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text('Details')),
      body: Column(
        children: [
          searchBar(),
          FutureBuilder<List<Contact>>(
            future: databaseHelper.fetchContact(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
              if (!snapshot.hasData) return Container();
              List<Contact> contacts = snapshot.data;
              print(contacts);
              return contactsViewWidget(contacts, isSearching);
            },
          ),
        ],
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
              myFocusNode.requestFocus();
            //   break;
            // case 2:
            //   break;
          }
        },
      ),
    );
  }

  Widget contactsViewWidget(contacts, isSearching) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      //isSearching ==true? contactsFiltered.length :
      // isSearching ==true? contactsFiltered.length :
      itemCount: filteredContact.length,
      itemBuilder: (BuildContext context, int position) {
        var contact =filteredContact[position];
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.perm_contact_cal),
            ),
            title: Text(contact.name),
            subtitle: Text(contact.remaining),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                showDeleteDialog(context, contact);
              },
            ),
            //i dont know how to pass that editmode = true or false value
            onTap: () {
              //Datapage void _save() it contains edit mode check look once
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataPage(contact:contact)),
              );
            },
          ),
        );
      },
    );
  }

  Widget searchBar(){
    return Container(
      height: 60,
      padding: EdgeInsets.all(8),
      child: TextField(
        autofocus: false,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(r'[A-Z,a-z, ]')),
          LengthLimitingTextInputFormatter(20),
        ],
        controller: searchController,
        focusNode: myFocusNode,
        onChanged: (value){
          filterContact(value);
        },
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          // color: Colors.white,
        ),
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            // fillColor: Colors.white, filled: true,
            labelText: 'Search'),
      ),

    );

  }



}
