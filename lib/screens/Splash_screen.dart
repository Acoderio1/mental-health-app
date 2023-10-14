import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_health/screens/home_screen.dart';
import 'package:m_health/screens/loadingg.dart';
import 'package:m_health/screens/signin_screen.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}
class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user){
      if (user != null) {
        print("user is logged in");
        Timer(Duration(seconds: 1),
                ()=>Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>
                    Loadinscreen()
                )
            )
        );
        //navigate to home page using Navigator Widget
      } else {
        print("user is not logged in");
        Timer(Duration(seconds: 1),
                ()=>Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>
                    SignInScreen()
                )
            )
        );
        //navigate to sign in page using Navigator Widget
      }
    });
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
