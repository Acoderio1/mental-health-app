import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_health/screens/home_screen.dart';
import 'package:m_health/screens/loadingg.dart';
import 'package:m_health/screens/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:m_health/screens/quiz_screen.dart';
import 'package:m_health/screens/screenbeforestartquiz.dart';
import 'package:m_health/utils/color_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;


class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {

  void initState() {
    super.initState();
    print("accessed home page");
    twitteranalysis();
    instaanalysis();
    gadTestscore();
    phqTestscore();
    getage();
  }



  var _twitterdepanalysis = "";
  var _twittersuianalysis = "";
  var _analyzetexttwit = "";

  var _instdepanalysis = "";
  var _instsuianalysis = "";
  var _analyzetextinst = "";

  var _gadscore = "0";
  int _gscore = 0;
  int _pscore = 0;

  var _phqscore = "0";
  var _gadtext = "";
  var _phqtext = "";

  bool _isLoadings = true;
  var _Agetext = "";
  var _Agescore = "";

  Future<void> getage() async{
    var _Age = 0;
    print("getagefuncstarted");
    var age = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/Age.json?"; // Do not remove “data.json”,keep it as it is
    try {
      final ageresponse = await http.get(Uri.parse(age));
      final ageextractedData = json.decode(ageresponse.body);
      print("got age data:");
      _Age = ageextractedData;
      print(_Age);
    } catch (error) {
      throw error;
    }
    if(_Age == 16){
      getunderMomScore();
    }
    else{
      getOverMomScore();
    }
  }


  Future<String> getunderMomScore() async{
    print("Momscorefuncstarted");
      var momScore = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/Underagescore.json?";

    print(momScore);
    var tempscore = 0;
    // Do not remove “data.json”,keep it as it is
    try {
      final depresponse = await http.get(Uri.parse(momScore));
      final depextractedData = json.decode(depresponse.body) as int;
      print(depextractedData);
      print("this is UnderageScore");
      tempscore = depextractedData;
      _Agescore = depextractedData.toString();
      print(_Agescore);

      if(tempscore <= 6){
        setState(() {
          _isLoadings = false;
        });
        return _Agetext = "Your mental health is bad";

      }
      if(tempscore as int > 6 && tempscore as int <= 12){
        setState(() {
          _isLoadings = false;
        });
        return _Agetext = "You have poor mental health";
      }
      if(tempscore > 12 && tempscore as int <= 18){
        _Agetext = "Your mental health is Good";
        setState(() {
          _isLoadings = false;
        });
        return _Agetext = "Your mental health is Good";

      }
      if(tempscore as int > 18){
        _Agetext = "Your mental health is Great";
        setState(() {
          _isLoadings = false;
        });
        return _Agetext = "Your mental health is Great";
      }
      setState(() {
        _isLoadings = false;
      });
    } catch (error) {
      throw error;
    }
    return _Agetext = "";
  }

  Future<String> getOverMomScore() async{
    print("Momscorefuncstarted");
    var momScore = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/Overagescore.json?";

    print(momScore);
    // Do not remove “data.json”,keep it as it is
    try {
      final depresponse = await http.get(Uri.parse(momScore));
      final depextractedData = json.decode(depresponse.body) as int;
      print(depextractedData);
      print("this is OverageScore");
      _Agescore = depextractedData.toString();
      print(_Agescore);
      setState(() {
        _isLoadings = false;
      });
    } catch (error) {
      throw error;
    }
    return _Agetext = "You are fine";
  }


  Color getgadtColor(int a) {
    // Some logic

    if (a <= 4) {
      return hexStringToColor("#02A951");
    }
    if (a > 4 && a< 10) {

      return hexStringToColor("#0238A2");
    }
    if (a > 9 && a < 15) {

      return hexStringToColor("#DE4200");
    }
    if (a >= 15 && a < 21) {

      return hexStringToColor("#D72531");
    }
    if (a == 50) {

      return hexStringToColor("#5C5C5C");
    }
    return hexStringToColor("#5C5C5C");
  }

  Color getphqtColor(int a) {
    // Some logic

    if (a <= 4) {
      return hexStringToColor("#02A951");
    }
    if (a > 4 && a< 10) {

      return hexStringToColor("#018DB1");
    }
    if (a > 9 && a < 15) {

      return hexStringToColor("#0238A2");
    }
    if (a > 14 && a < 20) {

      return hexStringToColor("#DE4200");
    }
    if (a > 19 && a <= 24) {

      return hexStringToColor("#D72531");
    }
    if (a == 50) {

      return hexStringToColor("#5C5C5C");
    }
    return hexStringToColor("#5C5C5C");
  }

  Color getTextColor(String a, String b) {
    // Some logic
    if (a == "Depressed" || b == "Suicidal"){
      return hexStringToColor("#DE4200");
    }
    return hexStringToColor("#5C5C5C");
  }


  Future<String> twitteranalysis() async{


    print("twitterfuncstarted");
    var twitterdep = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/Twitterdepanalysis.json?";
    var twittersui = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/Twittersuianalysis.json?";

    // Do not remove “data.json”,keep it as it is
    try {
      final depresponse = await http.get(Uri.parse(twitterdep));
      final depextractedData = json.decode(depresponse.body) as String;

      final suiresponse = await http.get(Uri.parse(twittersui));
      final suiextractedData = json.decode(suiresponse.body) as String;


      print(depextractedData);
      print(suiextractedData);

      if (depextractedData == "") {
        setState(() {
          _isLoadings = false;
        });
        return _analyzetexttwit = "Your profile has not been analaysed";
      }
      if (suiextractedData == "") {
        setState(() {
          _isLoadings = false;
        });
        return _analyzetexttwit = "Your profile has not been analaysed";
      }
      if (depextractedData == "Healthy" || suiextractedData == "Healthy") {
        _twitterdepanalysis = depextractedData as String;
        _twittersuianalysis = suiextractedData as String;

        setState(() {
          _isLoadings = false;
        });
        return _analyzetexttwit = "You are fine";
      }

      print("got analytics page data");
      _twitterdepanalysis = depextractedData as String;
      _twittersuianalysis = suiextractedData as String;

      setState(() {
        _isLoadings = false;
      });
    } catch (error) {
      throw error;
    }
    return _analyzetexttwit = "Please take GAD7 and PHQ8 questionnaire for further diagnosis";
  }

  Future<String> instaanalysis() async{


    print("twitterfuncstarted");
    var twitterdep = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/Instagramdepanalysis.json?";
    var twittersui = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/Instagramsuianalysis.json?";

    // Do not remove “data.json”,keep it as it is
    try {
      final depresponse = await http.get(Uri.parse(twitterdep));
      final depextractedData = json.decode(depresponse.body) as String;

      final suiresponse = await http.get(Uri.parse(twittersui));
      final suiextractedData = json.decode(suiresponse.body) as String;


      print(depextractedData);
      print(suiextractedData);

      if (depextractedData == "") {
        setState(() {
          _isLoadings = false;
        });
        return _analyzetextinst = "Your profile has not been analaysed";
      }
      if (suiextractedData == "") {
        setState(() {
          _isLoadings = false;
        });
        return _analyzetextinst = "Your profile has not been analaysed";
      }
      if (depextractedData == "Healthy" || suiextractedData == "Healthy") {
        _instdepanalysis = depextractedData as String;
        _instsuianalysis = suiextractedData as String;

        setState(() {
          _isLoadings = false;
        });
        return _analyzetexttwit = "You are fine";
      }

      print("got analytics page data");
      _instdepanalysis = depextractedData as String;
      _instsuianalysis = suiextractedData as String;

      setState(() {
        _isLoadings = false;
      });
    } catch (error) {
      throw error;
    }
    return _analyzetextinst = "Please take GAD7 and PHQ8 questionnaire for further diagnosis";
  }

  Future<String> gadTestscore() async{


    print("gadfuncstarted");
    var gad = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/GADscore.json?";

    // Do not remove “data.json”,keep it as it is
    try {
      final gadresponse = await http.get(Uri.parse(gad));
      final gadextractedData = json.decode(gadresponse.body) as int;
      _gscore = gadextractedData;
      print(gadextractedData);

      if (gadextractedData <= 4) {
        _gadscore = gadextractedData.toString();

        setState(() {
          _isLoadings = false;
        });
        return _gadtext = "You have been diagnosed with minimal anxiety";
      }
      if (gadextractedData > 4 && gadextractedData < 10) {
        _gadscore = gadextractedData.toString();

        setState(() {
          _isLoadings = false;
        });
        return _gadtext = "You have been diagnosed with mild anxiety";
      }
      if (gadextractedData > 9 && gadextractedData < 15) {
        _gadscore = gadextractedData.toString();

        setState(() {
          _isLoadings = false;
        });
        return _gadtext = "You have been diagnosed with moderate anxiety";
      }
      if (gadextractedData >= 15 && gadextractedData < 21) {
        _gadscore = gadextractedData.toString();

        setState(() {
          _isLoadings = false;
        });
        return _gadtext = "You have been diagnosed with severe anxiety";
      }

      print("got analytics page data");

      setState(() {
        _isLoadings = false;
      });
    } catch (error) {
      throw error;
    }
    return _gadtext = "Test not taken";
  }


  Future<String> phqTestscore() async{


    print("phqfuncstarted");
    var phq = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/PHQscore.json?";

    // Do not remove “data.json”,keep it as it is
    try {

      final phqresponse = await http.get(Uri.parse(phq));
      final phqextractedData = json.decode(phqresponse.body) as int;
      _pscore = phqextractedData;

      print(phqextractedData);


      if (phqextractedData <= 4) {
        _phqscore = phqextractedData.toString();
        setState(() {
          _isLoadings = false;
        });
        return _phqtext = "You do not have depression";
      }
      if (phqextractedData > 4 && phqextractedData < 10) {
        _phqscore = phqextractedData.toString();
        setState(() {
          _isLoadings = false;
        });
        return _phqtext = "You have been diagnosed with mild depression";
      }
      if (phqextractedData > 9 && phqextractedData < 15) {
        _phqscore = phqextractedData.toString();
        setState(() {
          _isLoadings = false;
        });
        return _phqtext = "You have been diagnosed with moderate depression";
      }
      if (phqextractedData > 14 && phqextractedData < 20) {
        _phqscore = phqextractedData.toString();
        setState(() {
          _isLoadings = false;
        });
        return _phqtext = "You have been diagnosed with moderately severe depression";
      }
      if (phqextractedData > 19 && phqextractedData <= 24) {
        _phqscore = phqextractedData.toString();
        setState(() {
          _isLoadings = false;
        });
        return _phqtext = "You have been diagnosed with severe depression";
      }

      print("got analytics page data");

      setState(() {
        _isLoadings = false;
      });
    } catch (error) {
      throw error;
    }
    return _phqtext = "Test not taken";
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
                          width: 400,
                          height: 1000,
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
                                    Container(
                                      child: Text("Analytics",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: hexStringToColor("#5C5C5C"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                    ),
                                    isLoading? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255))):
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(profileUrl),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 360,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: hexStringToColor("#D3A5E8"),
                                    borderRadius: BorderRadius.circular(35),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 5,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text("MOM Score: ",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: hexStringToColor("#FFFFFF"),
                                          ),),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      _isLoadings? CircularProgressIndicator(
                                          valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255))
                                      ):
                                      Container(
                                        width: 320,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: hexStringToColor("#FFFFFF"),
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15,0,0,10),
                                                  child: Text("${_Agescore}/24",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                      color: hexStringToColor("#6D64FF"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(15,0,15,0),
                                              child: Text("${_Agetext}",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: hexStringToColor("#5C5C5C"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: 360,
                                  height: 320,
                                  decoration: BoxDecoration(
                                    color: hexStringToColor("#D3A5E8"),
                                    borderRadius: BorderRadius.circular(35),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 5,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text("Analysis: ",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: hexStringToColor("#FFFFFF"),
                                          ),),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      _isLoadings? CircularProgressIndicator(
                                          valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255))
                                      ):
                                      Container(
                                        width: 320,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: hexStringToColor("#FFFFFF"),
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15,0,0,10),
                                                  child: Text("Twitter",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                      color: hexStringToColor("#6D64FF"),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(0,0,15,10),

                                                  child: Text("${_twitterdepanalysis}",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: getTextColor(_twitterdepanalysis, _twittersuianalysis),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(0,0,15,10),

                                                  child: Text("${_twittersuianalysis}",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: getTextColor(_twitterdepanalysis, _twittersuianalysis),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(15,0,15,0),
                                              child: Text("${_analyzetexttwit}",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: hexStringToColor("#5C5C5C"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      _isLoadings? CircularProgressIndicator(
                                          valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255))
                                      ):

                                      Container(
                                        width: 320,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: hexStringToColor("#FFFFFF"),
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15,0,0,10),
                                                  child: Text("Instagram",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                      color: hexStringToColor("#6D64FF"),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(0,0,15,10),

                                                  child: Text("${_instdepanalysis}",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: getTextColor(_instdepanalysis, _instsuianalysis),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(0,0,15,10),

                                                  child: Text("${_instsuianalysis}",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: getTextColor(_instdepanalysis, _instsuianalysis),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(15,0,15,0),
                                              child: Text("${_analyzetextinst}",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: hexStringToColor("#5C5C5C"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: 360,
                                  height: 320,
                                  decoration: BoxDecoration(
                                    color: hexStringToColor("#D3A5E8"),
                                    borderRadius: BorderRadius.circular(35),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 5,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text("Test Score: ",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: hexStringToColor("#FFFFFF"),
                                          ),),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      _isLoadings? CircularProgressIndicator(
                                          valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255))
                                      ):
                                      Container(
                                        width: 320,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: hexStringToColor("#FFFFFF"),
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15,0,0,10),
                                                  child: Text("GAD7",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                      color: hexStringToColor("#6D64FF"),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(0,0,15,10),

                                                  child: Text("${_gadscore.toString()}",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                      color: getgadtColor(_gscore)
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(15,0,15,0),
                                              child: Text("${_gadtext}",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: hexStringToColor("#5C5C5C"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      _isLoadings? CircularProgressIndicator(
                                          valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255))
                                      ):
                                      Container(
                                        width: 320,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: hexStringToColor("#FFFFFF"),
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15,0,0,10),
                                                  child: Text("PHQ8",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                      color: hexStringToColor("#6D64FF"),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(0,0,15,10),

                                                  child: Text("${_phqscore}",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                      color: getphqtColor(_pscore),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(15,0,15,0),
                                              child: Text("${_phqtext}",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: hexStringToColor("#5C5C5C"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
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
                icon: const Icon(Icons.home_outlined, size: 30),
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const HomeScreen())),

            ),
            IconButton(
                icon: const Icon(Icons.dashboard, size: 30),
                onPressed: () {
                }
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







