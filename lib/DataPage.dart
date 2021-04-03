import 'package:clean_app/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clean_app/Contact.dart';
import 'package:clean_app/DatabaseHelper.dart';

class DataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
  Contact contact;

  DataPage({this.contact});
}

class _State extends State<DataPage> {
  DatabaseHelper helper = DatabaseHelper();
  Contact contact;
  double raw = 0.01, total = 0.02, remaining = 0.01, numOne = 0.03;
  int numTwo = 1, rawTotal = 2;
  String totalOne = 'a', totalTwo = 'b';

  @override
  void initState() {
    contact = widget.contact ?? Contact();

    nameController.text = contact.name;
    phoneController.text = contact.phone;
    myController.text = contact.time;
    timeController.text = contact.costperhour;
    paidController.text = contact.paidamount;
    totalController.text = contact.total;
    remainingController.text = contact.remaining;
  }

  String onChanged() {
    //solution for invalid double
    if (timeController.text == '') {
      timeController.text = '0';
    }
    if (myController.text == '') {
      myController.text = '0';
    }
    if (paidController.text == '') {
      paidController.text = '0';
    }

    numOne = double.parse(myController.text);
    raw = double.parse(timeController.text);
    numTwo = numOne.toInt();
    total = numTwo * raw + (numOne - numTwo) * raw * 100 / 60;
    totalOne = total.toString();
    return totalOne;
  }

  void clearEverything() {
    //make textfield empty
    totalController.text = '';
    timeController.text = '';
    myController.text = '';
    nameController.text = '';
    remainingController.text = '';
    paidController.text = '';
    phoneController.text = '';
  }

  void calculateData() {
    //to calcyulate the data
    String newOne;
    double raw, remain;
    newOne = onChanged();
    totalController.text = newOne;
    raw = double.parse(paidController.text);
    remain = double.parse(newOne) - raw;
    remainingController.text = '$remain';
  }

  void fillChanged() {
    //to instantly calculate the data
    setState(() {
      calculateData();
    });
  }

// void showDialogForSavedOrNot(BuildContext context, int i){
//     showDialog(context: context, builder: builder)
// }
  void _showDialog(BuildContext context) {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!"),
          backgroundColor: Colors.white,
          content: new Text("Do you really Want to Clear?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              textColor: Colors.white,
              minWidth: 100,
              color: Colors.red,
              onPressed: () {
                clearEverything();
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

  //this function to copy  textfield values to contact
  void saveData() {
    contact.name = nameController.text;
    contact.phone = phoneController.text;
    contact.time = myController.text;
    contact.costperhour = timeController.text;
    contact.paidamount = paidController.text;
    contact.total = totalController.text;
    contact.remaining = remainingController.text;
    _save();

    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainMenu()),
    );
    clearEverything();
  }

  void _save() async {
    //check edit mode here
    int result;
    if (contact.id != null) {
      result = await helper.updateContact(contact);
    } else {
      // print("contact"+contact);
      result = await helper.insertContact(contact);
    }

    // result = await helper.insertContact(contact);
    if (result != 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Notice!!"),
              backgroundColor: Colors.white,
              content: Text('Saved Sucessfully'),
            );
          });
    }
    if (result == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Notice!!"),
              backgroundColor: Colors.white,
              content: Text('Task Failed Sucessfully'),
            );
          });
    }
  }

//this function to show save data dialog before saving to database
  void _showDialogForSaving(BuildContext context) {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Notice!!"),
          backgroundColor: Colors.white,
          content: new Text("Do you really Want to Save?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              textColor: Colors.white,
              minWidth: 100,
              color: Colors.red,
              onPressed: () {
                saveData(); //this line is giving error
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

  TextEditingController totalController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController myController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController remainingController = TextEditingController();
  TextEditingController paidController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Data and Money'),
          backgroundColor: Colors.red,
        ),
        body: new Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(children: <Widget>[
                  Container(
                    height: 58,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Z,a-z, ]')),
                        LengthLimitingTextInputFormatter(20),
                      ],
                      controller: nameController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        // color: Colors.white,
                      ),
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // fillColor: Colors.white, filled: true,
                          labelText: 'नाम'),
                    ),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: phoneController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // fillColor: Colors.white, filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'फोन नम्बर ',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      controller: myController,
                      // onTap: () {
                      //   setState(() {
                      //     calculateData();
                      //   });
                      // },
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                        LengthLimitingTextInputFormatter(5),
                      ],
                      // obscureText: true,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'काम गरेको समय',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      controller: timeController,
                      // onTap: () {
                      //   setState(() {
                      //     calculateData();
                      //   });
                      // },
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      // obscureText: true,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'प्रती घण्टा को',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      controller: paidController,
                      onSubmitted: (String) {
                        setState(() {
                          calculateData();
                        });
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      // obscureText: true,
                      //controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'तिरेको रकम रु',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      controller: totalController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'तिर्नु पर्ने रकम रु',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      controller: remainingController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      // obscureText: true,
                      //controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'बाकी रकम रु',
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          minWidth: 170,
                          height: 50,
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Calculate & Save'),
                          onPressed: () {
                            calculateData();
                            _showDialogForSaving(context);
                            //  new Future.delayed(const Duration(seconds : 5));
                            //fill data
                          },
                        ),
                        SizedBox(width: 50),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          minWidth: 170,
                          height: 50,
                          textColor: Colors.white,
                          color: Colors.red,
                          child: Text('Clear'),
                          onPressed: () {
                            _showDialog(context);
                          },
                        ),
                      ],
                      // padding: EdgeInsets.symmetric(horizontal:12, vertical: 12),
                    ),
                  )
                ]))));
  }

//   _refreshContactList() async{
}
