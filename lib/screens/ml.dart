import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/home_screen.dart';


void getplaylist() async{

  print("getting playlist");
  var purl = "http://10.0.2.2:5000/userplaylist/.json?";
  // Do not remove “data.json”,keep it as it is
  try {
    final presponse = await http.get(Uri.parse(purl));
    final pextractedData = json.decode(presponse.body) as String;


    print(pextractedData);


    if (pextractedData == null) {
      return;
    }

  } catch (error) {
    throw error;
  }

}