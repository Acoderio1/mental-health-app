import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_health/screens/analytics.dart';
import 'package:m_health/screens/loadingg.dart';
import 'package:m_health/screens/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:m_health/screens/quiz_screen.dart';
import 'package:m_health/screens/screenbeforestartquiz.dart';
import 'package:m_health/utils/color_utils.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

DateTime date = DateTime.now();
String dateFormat = DateFormat('EEEE, d MMM, yyyy').format(date);
TextEditingController _twitterFieldController = TextEditingController();
TextEditingController _instaFieldController = TextEditingController();

get twitterid => _twitterFieldController.value.text;
get instaid => _instaFieldController.value.text;

bool _istwitterloading = false;
bool _isinstaloading = false;



class _HomeScreenState extends State<HomeScreen> {
  var _imageurl = "";
  var _songname = "";
  var _songartist = "";
  void initState() {
    super.initState();
    print("accessed home page");
  }



  Future gettwitterDat() async {
    setState(() {
      _istwitterloading = true;
    });
    print(twitterid);
    final suiresponse = await http.get(Uri.parse("http://10.0.2.2:5000/twittersuicideml/"+twitterid));
    final suiextractedData = json.decode(suiresponse.body);
    final depresponse = await http.get(Uri.parse("http://10.0.2.2:5000/twitterdepml/"+twitterid));
    final depextractedData = json.decode(depresponse.body);
    setState(() {
      _istwitterloading = false;
    });
    String twittersui = suiextractedData['quer'];
    String twitterdep = depextractedData['quer'];

    final DBRef = FirebaseDatabase.instance.ref().child('Users');
    DBRef.child(userId).update({
      'Twittersuianalysis' : twittersui,
      'Twitterdepanalysis' : twitterdep

    });
    _twitterFieldController.clear();
    print("uploaded Twitterdepanalysis in database");
  }

  Future getinstaDat() async {
    setState(() {
      _isinstaloading = true;
    });
    print(instaid);
    final suiresponse = await http.get(Uri.parse("http://10.0.2.2:5000/instasuiml/"+instaid));
    final suiextractedData = json.decode(suiresponse.body);

    final depresponse = await http.get(Uri.parse("http://10.0.2.2:5000/instadepml/"+instaid));
    final depextractedData = json.decode(depresponse.body);

    setState(() {
      _isinstaloading = false;
    });
    String instasui = suiextractedData['quer'];
    String instadep = depextractedData['quer'];


    final DBRef = FirebaseDatabase.instance.ref().child('Users');
    DBRef.child(userId).update({
      'Instagramsuianalysis' : instasui,
      'Instagramdepanalysis' : instadep,


    });
    _instaFieldController.clear();
    print("uploaded Instagramsuianalysis in database");
  }



  Future<void> _displayTextInputDialogtwit(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
          ),
          title: Text('Enter Twitter ID', style: TextStyle(fontFamily: "Montserrat", color: Color.fromARGB(255,92,92,92)),),
          content: TextField(
            controller: _twitterFieldController,
            decoration: InputDecoration(hintText: "Twitter ID", hintStyle: TextStyle(fontFamily: "Montserrat", color: Color.fromARGB(255,92,92,92))),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL',style: TextStyle(fontFamily: "Montserrat", color: Color.fromARGB(255,92,92,92))),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK',style: TextStyle(fontFamily: "Montserrat", color: Color.fromARGB(255,92,92,92))),
              onPressed: () {
                print(twitterid);
                gettwitterDat();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> _displayTextInputDialoginst(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)
          ),
          title: Text('Enter Instagram ID', style: TextStyle(fontFamily: "Montserrat", color: Color.fromARGB(255,92,92,92)),),
          content: TextField(
            controller: _instaFieldController,
            decoration: InputDecoration(hintText: "Instagram ID", hintStyle: TextStyle(fontFamily: "Montserrat", color: Color.fromARGB(255,92,92,92))),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL',style: TextStyle(fontFamily: "Montserrat", color: Color.fromARGB(255,92,92,92))),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK',style: TextStyle(fontFamily: "Montserrat", color: Color.fromARGB(255,92,92,92))),
              onPressed: () {
                print(instaid);
                getinstaDat();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }


  double _width = 400;
  double _height = 448;
  Color _color = Colors.white;
  int _index = 0;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(        extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/bkg.png'),
            fit: BoxFit.fill,

          ),
        ),
        child: Column(
          children: [
            Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(19,50,0,0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("${dateFormat}", style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255,92,92,92),
                              fontSize: 18
                            ),),
                          )),
                        Container(
                            padding: EdgeInsets.fromLTRB(19,5,0,30),
                            child: Align(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Good Morning!",textAlign: TextAlign.end, style: TextStyle(
                                      fontSize: 40,
                                      color: Color.fromARGB(255,92,92,92),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: isLoading
                                      ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255)))
                                       : Text("${username}",textAlign: TextAlign.end, style: TextStyle(
                                      fontSize: 40,
                                      color: Color.fromARGB(255,92,92,92),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  )
                                ],
                              ),
                            )),
                        Container(
                          width: 400,
                          height: MediaQuery.of(context).size.height*.21,
                          padding: EdgeInsets.fromLTRB(27,20,27,20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: hexStringToColor("#C490E4"),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("You can't go back and change the beginning, but you can start where you are and change the ending.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: "Montserrat",
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 400,
                          height: 238,
                          decoration: BoxDecoration(
                            color: _color,
                            borderRadius: _borderRadius,
                          ),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Analyse yourself",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: hexStringToColor("#5C5C5C"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => const PhqScreen()));
                                      },
                                      child:
                                      Container(
                                        padding: EdgeInsets.fromLTRB(15,0,0,10),
                                        alignment: Alignment.bottomLeft,
                                        width: 170,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: hexStringToColor("#C490E4"),
                                        ),
                                        child: Text("PHQ8",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => const QadScreen()));
                                      },
                                      child:
                                      Container(
                                        padding: EdgeInsets.fromLTRB(15,0,0,10),
                                        alignment: Alignment.bottomLeft,
                                        width: 170,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: hexStringToColor("#C1FFD7"),
                                        ),
                                        child: Text("GAD7",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 400,
                          height: 330,
                          decoration: BoxDecoration(
                            color: _color,
                            borderRadius: _borderRadius,
                          ),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Social Analysis",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: hexStringToColor("#5C5C5C"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _displayTextInputDialogtwit(context);
                                  },
                                  child:
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15,0,0,15),
                                    alignment: Alignment.bottomLeft,
                                    width: 360,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: hexStringToColor("#C490E4"),
                                    ),
                                    child: Row(
                                      children: [
                                        Text("Twitter",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                        SizedBox(
                                          width: 180,
                                        ),
                                        _istwitterloading
                                            ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255)))
                                            : Icon(Icons.cloud_done_rounded, color: Colors.white, size: 30,),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _displayTextInputDialoginst(context);
                                  },
                                  child:
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15,0,0,15),
                                    alignment: Alignment.bottomLeft,
                                    width: 360,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: hexStringToColor("#C1FFD7"),
                                    ),
                                    child: Row(
                                      children: [
                                        Text("Instagram",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                        SizedBox(
                                          width: 130,
                                        ),
                                        _isinstaloading
                                            ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255)))
                                            : Icon(Icons.cloud_done_rounded, color: Colors.white, size: 30,),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(15,0,0,10),
                                  alignment: Alignment.bottomLeft,
                                  width: 360,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: hexStringToColor("#B5DEFF"),
                                  ),
                                  child: Text("Facebook",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 400,
                          height: 960,
                          decoration: BoxDecoration(
                            color: _color,
                            borderRadius: _borderRadius,
                          ),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Music",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: hexStringToColor("#5C5C5C"),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    for(var item in map1.keys)
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0,10,0,0),
                                        padding: EdgeInsets.fromLTRB(10,6,0,0),
                                        width: 360,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color: hexStringToColor("#FFFFFF"),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 65,
                                              height: 65,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(getimage(item),),
                                                    fit: BoxFit.cover,
                                                  ),
                                                borderRadius: BorderRadius.circular(20)
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${item}",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(255,109,100,255),
                                                      fontFamily: "Montserrat",
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    )
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text("${getartist(item)}",
                                                    style: TextStyle(
                                                      color: hexStringToColor("#5C5C5C"),
                                                      fontFamily: "Montserrat",
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                    )
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(17,0,17,10),
        width: 10,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [new BoxShadow(
            color: Colors.black38,
            blurRadius: 35.0,
            offset: Offset(0,10)
          ),],
          color: Colors.white,
            borderRadius: BorderRadius.circular(50)
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 30),
                onPressed: () {}

            ),
            IconButton(
              icon: const Icon(Icons.dashboard_outlined, size: 30),
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const AnalyticsScreen())),
            ),
            IconButton(
              icon: const Icon(Icons.person_outline, size: 30),
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const ProfileScreen())),

            ),IconButton(
              icon: const Icon(Icons.pending_actions_outlined, size: 30),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const StartScreen())),
            ),

          ],
        ),
      ),
      );
  }
}







