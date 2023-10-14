import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:m_health/database/database.dart';
import 'package:m_health/reusable_widgets/reusable_widget.dart';
import 'package:m_health/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:math';



class Loadinscreen extends StatefulWidget {
  @override
  _LoadinscreenState createState() => _LoadinscreenState();
}
bool isLoading = true;


var profileUrl = "";
var username = "";
var email = "";
var userId = "";

Random random = new Random();
var randomNumber = ((random.nextInt(50) + 50)/100).toStringAsFixed(1);

Map<String, Map<String, String>> map1 = {};

String getimage(String name){
  final usd = map1[name] as Map<String, dynamic>;

  return usd['songimage'];
}

String getartist(String name){
  final usd = map1[name] as Map<String, dynamic>;

  return usd['songartist'];
}


void getplaylist() async{
  print(randomNumber);
  var url = "https://api.spotify.com/v1/recommendations?limit=10&market=ES&seed_artists=4NHQUGzhtTLFvgF5SZesLK&seed_genres=pop&seed_tracks=0c6xIDDpzE81m2q797ordA&min_valence=0.5&max_valence="+randomNumber+"&target_valence=1";

  var headers = {
    HttpHeaders.acceptHeader:'application/json',
    HttpHeaders.authorizationHeader: 'Bearer BQDSHb5Jl4v5IgKREGSJXQYk029-drqIDMiS7MQWmyB9HJbZdcAhAXyKjlgybsb8PRqJ2YrIBFs7pDR-sGtP_4pXY0ERc2vWAkgNWMxawUqju-aNDTWsAL6hko7mC-6r6CQA6bPU2v4Bc0yAzFF7m39tricqKkM',
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  var response = await http.get(Uri.parse(url), headers: headers);
  var data = jsonDecode(response.body);
  var songid = [];
  var songname = [];
  var songartist = [];
  var songimage = [];
  var t  = data["tracks"];
  for (var i = 0 ; i <= 9; i++){
    songid.add(t[i]["album"]["artists"][0]["id"]);
    songname.add(t[i]["album"]["name"]);
    songartist.add(t[i]["album"]["artists"][0]["name"]);
    songimage.add(t[i]["album"]["images"][0]["url"]);
  }

  for (var i = 0; i <= 9; i++){
    map1[songname[i]] = {'songid': songid[i], "songartist": songartist[i], "songimage": songimage[i]};
  }
  final usd = map1['Tasty'] as Map<String, dynamic>;

  print(usd['songimage']);
}

class _LoadinscreenState extends State<Loadinscreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 7),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomeScreen())
        ),
    );
    userId = getUid();
    profilePic();
    getplaylist();

  }






  void profilePic() async{


    print("picurlfuncstarted");
    var purl = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/profilePic.json?";
    var eurl = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/Email.json?";
    var uurl = "https://mentalhealth-1ef40-default-rtdb.firebaseio.com/Users/"+ userId +"/Name.json?";

    // Do not remove “data.json”,keep it as it is
    try {
      final presponse = await http.get(Uri.parse(purl));
      final pextractedData = json.decode(presponse.body) as String;

      final eresponse = await http.get(Uri.parse(eurl));
      final eextractedData = json.decode(eresponse.body) as String;

      final uresponse = await http.get(Uri.parse(uurl));
      final uextractedData = json.decode(uresponse.body) as String;

      print(pextractedData);
      print(uextractedData);
      print(eextractedData);

      if (pextractedData == null) {
        return;
      }
      if (eextractedData == null) {
        return;
      }
      if (uextractedData == null) {
        return;
      }
      print("got profile page data");
      profileUrl = pextractedData;
      username = uextractedData as String;
      email = eextractedData as String;

      print(profileUrl);
      print(username);
      print(email);

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      throw error;
    }
  }






  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(
              'assets/logo.png'),
        ),
      ),
    );
  }
}
