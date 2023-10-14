import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../database/database.dart';
import 'home_screen.dart';



class PhqquizScreen extends StatefulWidget {
  const PhqquizScreen({Key? key}) : super(key: key);

  @override
  _PhqquizScreenState createState() => _PhqquizScreenState();
}

class _PhqquizScreenState extends State<PhqquizScreen> {
  String _useri = "";
  bool _isdisable = true;
  bool _isdisables = false;


  void initState() {
    super.initState();
    print("accessed finalquiz page");
    _useri = getUid();
  }

  String textHolder = 'Little interest or pleasure in';
  List<String> strArr = ['Feeling down depressed, or hopeless', 'Trouble falling or staying asleep, or sleeping too much' , 'Feeling tired or having little energy', 'Poor appetite or overeating', 'Feeling bad about yourself, or that you are a failure, or have let yourself or your family down', 'Trouble concentrating on things, such as reading the newspaper or watching television.','Moving or speaking so slowly that other people could have noticed. Or the opposite being so fidgety or restless that you have been moving around a lot more than usual','Test has ended, Please submit.'];
  int counter = 0;
  int _point = 0;

  changeText() {
    setState(() {
        textHolder = strArr[counter];
        counter = counter + 1;
        if (counter >= 7){
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
      'PHQscore' : _point
    });
    print("uploaded PHQ in database");
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
                      child: Text('Not at all',
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
                      child: Text('Several days',
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
                      child: Text('More than half the days',
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
                      child: Text('Nearly every day',
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
                    MaterialPageRoute(builder: (context) => const HomeScreen()))},
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


class QadquizScreen extends StatefulWidget {
  const QadquizScreen({Key? key}) : super(key: key);

  @override
  _QadquizScreenState createState() => _QadquizScreenState();
}

class _QadquizScreenState extends State<QadquizScreen> {

  String _useri = "";
  bool _isdisable = true;
  bool _isdisables = false;


  void initState() {
    super.initState();
    print("accessed QADquiz page");
    _useri = getUid();
  }

  String textHolder1 = 'Feeling nervous, anxious or on edge';
  List<String> strArr1 = ['Not being able to stop or control worrying' , 'Worrying too much about different things', 'Trouble relaxing', 'Being so restless it is hard to sit still', 'Becoming easily annoyed or irritable','Feeling afraid as if something awful might happen ','Test has ended, Please submit.'];
  int counter1 = 0;
  int _point1 = 0;
  changeText() {
    setState(() {
      textHolder1 = strArr1[counter1];
      counter1 = counter1 + 1;
      if (counter1 >= 7){
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
      'GADscore' : _point1
    });
    print("uploaded QAD in database");
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
                      child: Text('Not at all',
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
                      child: Text('Several days',
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
                      child: Text('More than half the days',
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
                      child: Text('Nearly every day',
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
                    MaterialPageRoute(builder: (context) => const HomeScreen()))},
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














