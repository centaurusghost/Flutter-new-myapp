import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maternuncle/DatabaseHelper.dart';
import 'package:maternuncle/peoples.dart';
import 'nextpage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();

  Peoples person;
  bool editMode = false;

  LoginPage({this.editMode, this.person});
}

class _State extends State<LoginPage> {
  // bool _isVisible = false;
  double raw = 0.01, total = 0.02, remaining = 0.01, numOne = 0.03;
  int numTwo = 1, rawTotal = 2;
  String totalOne = 'a', totalTwo = 'b';

  @override
  void initState() {
    print("dfde");
    if (widget.editMode) {
      print("editmode" + widget.editMode.toString());
      totalController.text = '';
      timeController.text = '';
      myController.text = '';
      nameController.text = widget.person.name;
      remainingController.text = '';
      paidController.text = '';
      phoneController.text = widget.person.phone;
    }
  }

  String onChanged() {
    numOne = double.parse(myController.text != "" ? myController.text : "0");
    raw = double.parse(timeController.text);
    numTwo = numOne.toInt();
    total = numTwo * raw + (numOne - numTwo) * raw * 100 / 60;
    totalOne = total.toString();
    return totalOne;
  }

  void clearEverything() {
    totalController.text = '';
    timeController.text = '';
    myController.text = '';
    nameController.text = '';
    remainingController.text = '';
    paidController.text = '';
    phoneController.text = '';
  }

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
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //    image: AssetImage("lib/images/wallp.jpg"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(children: <Widget>[
                  Container(
                    height: 58,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
                    child: TextField(
                      inputFormatters: [
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
                      inputFormatters: [
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
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
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
                          child: Text('Save'),
                          onPressed: () async {
                            String newOne, remainOne;
                            double raw, remain;
                            newOne = onChanged();
                            totalController.text = newOne;
                            raw = double.parse(paidController.text);
                            remain = double.parse(newOne) - raw;
                            remainingController.text = '$remain';
                            Peoples person = new Peoples(
                                id: widget.person?.id??null,
                                phone: phoneController.text,
                                name: myController.text);
                            widget.editMode
                                ? dbHelper.update(person)
                                : dbHelper.save(person);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NextPage()),
                            );
                            // List<Peoples> list_of_peoples = await dbHelper.getPeoples();
                            // print("list_of_peoles"+list_of_peoples[0].name.toString());
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
                            // AlertDialog(
                            //   title: Text('Alert!!'),
                            //   content: Text('Do you really want to exit?'),
                            //   actions: [
                            //     new FlatButton(onPressed: (){}, child: Text('Yes')),
                            //     new FlatButton(onPressed: (){}, child: Text('No')),
                            //   ],
                            // );

                            // Navigator.push(context,
                            //   MaterialPageRoute(builder: (context)=>NextPage()),
                            // );
                          },
                        ),
                      ],
                      // padding: EdgeInsets.symmetric(horizontal:12, vertical: 12),
                    ),
                  )
                ]))));
  }
}
