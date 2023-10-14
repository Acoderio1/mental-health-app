import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import '../screens/signup_screen.dart';




  final DBRef = FirebaseDatabase.instance.ref().child('Users');

  void writeData(){
    DBRef.child(userid).set({
      'Name': username,
      'Email':useremail,
      'profilePic' : "https://firebasestorage.googleapis.com/v0/b/mentalhealth-1ef40.appspot.com/o/028d394ffb00cb7a4b2ef9915a384fd9.webp?alt=media&token=34d39599-e9d8-4d08-a7a3-25d9b60da05c",
      'GADscore': 50,
      "PHQscore": 50,
      'Twittersuianalysis' : "",
      'Twitterdepanalysis' : "",
      'Instagramsuianalysis' : "",
      'Instagramdepanalysis' : "",
      'Age': 0,
      'Overagescore' : 0,
      'Underagescore' :0
    });
    print("done data");
  }

  String getUid(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    String useri = "";
    final User? user = auth.currentUser;
    useri = user?.uid as String;
    print(useri);
    return useri;// here you write the codes to input the data into firestore
  }



  