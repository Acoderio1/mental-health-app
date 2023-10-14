import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_health/database/database.dart';
import 'package:m_health/screens/analytics.dart';
import 'package:m_health/screens/loadingg.dart';
import 'package:m_health/screens/screenbeforestartquiz.dart';
import 'package:m_health/screens/signin_screen.dart';
import 'package:path/path.dart';

import 'home_screen.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {




  String _useri = "";
  void initState() {
    super.initState();
    print("accessed profile page");
    _useri = getUid();
  }


late XFile _image;

FirebaseStorage _storage = FirebaseStorage.instance;

Future getImage() async{

  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  setState(() {
    _image = image as XFile;
  });
  print("gotimage");

  Reference ref = _storage.ref().child("$_useri.png");
  UploadTask uploadTask = ref.putFile(File(_image.path));
  TaskSnapshot snapshot = await uploadTask;
  String imageUrl = await snapshot.ref.getDownloadURL();
  print("uploaded image in storage");
  print(imageUrl);
  final DBRef = FirebaseDatabase.instance.ref().child('Users');
  DBRef.child(_useri).update({
    'profilePic' : imageUrl
  });
  print("uploaded imageUrl in database");

}




@override
  Widget build(BuildContext context) {
    return Scaffold(        extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/bkg.png'),
            fit: BoxFit.fill,

          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255))):
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(profileUrl),
              child: IconButton(onPressed: () async{
                getImage();
              },
                  icon: Icon(Icons.camera_alt), alignment: Alignment.bottomLeft, padding: EdgeInsets.fromLTRB(140,135,0,0),color: Color.fromARGB(255,92,92,92),),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0,5,0,0),
                child: Align(
                  alignment: Alignment.center,
                  child: isLoading
                      ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255)))
                      : Text("${username}", style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255,92,92,92),
                      fontSize: 50,
                  ),),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(0,0,0,0),
                child: Align(
                  alignment: Alignment.center,
                  child: isLoading
                      ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255,109,100,255)))
                      : Text("${email}", style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255,92,92,92),
                      fontSize: 18,
                  ),),
                )),
            SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 280,
              height: 51,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,109,100,255)),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                child: Text("Logout",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal, fontSize: 23, fontFamily: "Montserrat"),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) => SignInScreen()),
                            (Route<dynamic> route) => false);
                  });
                },
              ),
            ),
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
              icon: const Icon(Icons.dashboard_outlined, size: 30),
              onPressed: () => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AnalyticsScreen())),
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 30),
                onPressed: () {}

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













