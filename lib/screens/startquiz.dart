import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:m_health/screens/loadingg.dart';
import '../database/database.dart';
import 'home_screen.dart';



class UnderageScreen extends StatefulWidget {
  const UnderageScreen({Key? key}) : super(key: key);

  @override
  _UnderageScreenState createState() => _UnderageScreenState();
}

class _UnderageScreenState extends State<UnderageScreen> {
  String _useri = "";
  bool _isdisable = true;
  bool _isdisables = false;


  void initState() {
    super.initState();
    print("accessed finalquiz page");
    _useri = getUid();
  }

  String textHolder = 'How often do you exercise?';
  List<String> strArr = ['How often do you meet more than five persons in a day?', 'Do you maintain a proper sleep schedule?' , 'How often do you feel like interacting with others?', 'Do you do well at academics?', 'Do you indulge in sports or extracurricular activities?', 'How often do you cherish your relationships?','How often do you voluntarily stay away from addictions like drinking and smoking?','Test has ended, Please submit.'];
  int counter = 0;
  int _point = 0;

  changeText() {
    setState(() {
      textHolder = strArr[counter];
      counter = counter + 1;
      if (counter >= 8){
        _isdisable = false;
        _isdisables = true;

      }
    });
  }

  pointFunction(int value){
    _point = _point + value;
    print(_point);

  }

  updatePHQ(){

    final DBRef = FirebaseDatabase.instance.ref().child('Users');
    DBRef.child(_useri).update({
      'Underagescore' : _point,
      'Age' : 16
    });
    print("uploaded agescore in database");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(        extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255,191,222,255),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text('$textHolder',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                )),
            Container(
              padding: EdgeInsets.fromLTRB(10,0,10,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 196, 144, 228)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed: _isdisables? null : () => {changeText(), pointFunction(0)},
                      child: Text('Very Often',
                        style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 196, 144, 228)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed: _isdisables? null : () => {changeText(), pointFunction(1)},
                      child: Text('Often',
                        style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10,0,10,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 196, 144, 228)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed: _isdisables? null : () => {changeText(), pointFunction(2)},
                      child: Text('Sometimes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 196, 144, 228)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed: _isdisables? null : () => {changeText(), pointFunction(3)},
                      child: Text('Almost never',
                        style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
                width: 280,
                height: 51,
                child: ElevatedButton(onPressed: _isdisable? null : () => {updatePHQ(), Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Loadinscreen()))},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,109,100,255)),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                  child: Text("Submit",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal, fontSize: 23, fontFamily: "Montserrat"),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}


class OverageScreen extends StatefulWidget {
  const OverageScreen({Key? key}) : super(key: key);

  @override
  _OverageScreenState createState() => _OverageScreenState();
}

class _OverageScreenState extends State<OverageScreen> {

  String _useri = "";
  bool _isdisable = true;
  bool _isdisables = false;


  void initState() {
    super.initState();
    print("accessed QADquiz page");
    _useri = getUid();
  }

  String textHolder1 = 'How often do you exercise?';
  List<String> strArr1 = ['How often do you meet more than five persons in a day?' , 'How often do you experience a sound sleep?', 'How often do you enjoy your daily chores?', 'Felt capable of making decisions about things?', 'How often do you feel that you are ill?','How often do you go fighting without your family','How often do you voluntarily stay away from addictions like drinking and smoking','Test has ended, Please Submit.'];
  int counter1 = 0;
  int _point1 = 0;
  changeText() {
    setState(() {
      textHolder1 = strArr1[counter1];
      counter1 = counter1 + 1;
      if (counter1 >= 8){
        _isdisable = false;
        _isdisables = true;

      }
    });
  }

  pointFunction(int value){
    _point1 = _point1 + value;
    print(_point1);

  }

  updateQAD(){

    final DBRef = FirebaseDatabase.instance.ref().child('Users');
    DBRef.child(_useri).update({
      'Overagescore' : _point1,
      'Age' : 30
    });
    print("uploaded agescore in database");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(        extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255,181,222,255),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text('$textHolder1',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                )),
            Container(
              padding: EdgeInsets.fromLTRB(10,0,10,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 196, 144, 228)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed: _isdisables? null : () => {changeText(), pointFunction(0)},
                      child: Text('Very Often',
                        style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 196, 144, 228)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed: _isdisables? null :() => {changeText(), pointFunction(1)},
                      child: Text('Often',
                        style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10,0,10,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 196, 144, 228)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed: _isdisables? null : () => {changeText(), pointFunction(2)},
                      child: Text('Sometimes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 196, 144, 228)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed: _isdisables? null : () => {changeText(), pointFunction(3)},
                      child: Text('Almost never',
                        style: TextStyle(
                            fontFamily: "Monserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
                width: 280,
                height: 51,
                child: ElevatedButton(onPressed: _isdisable? null : () => {updateQAD(), Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Loadinscreen()))},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,109,100,255)),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                  child: Text("Submit",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal, fontSize: 23, fontFamily: "Montserrat"),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}














