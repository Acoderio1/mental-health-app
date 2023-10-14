import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:m_health/screens/loadingg.dart';
import 'package:m_health/screens/screenbeforestartquiz.dart';
import 'package:m_health/screens/signin_screen.dart';
import '../database/database.dart';

import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
String s = "";
var userid = '';
var useremail = '';
var username = '';
class _SignUpScreenState extends State<SignUpScreen> {
  var _text = "";
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override

  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  String? get _uText {
    // at any time, we can get the text from _controller.value.text
    final text = _userController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  String? get _eText {
    // at any time, we can get the text from _controller.value.text
    final text = _emailController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    if (!text.contains("@")){
      return 'Invalid email';
    }
    // return null if the text is valid
    return null;
  }

  String? get _pText {
    // at any time, we can get the text from _controller.value.text
    final text = _passController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    if (!text.contains(RegExp(r'[!#$%&()*+,-./:;<=>?@[\]^_`{|}~]'))){
      return 'Include special Character';
    }
    if (!text.contains(RegExp(r'[123456789]'))){
      return 'Include Number';
    }
    // return null if the text is valid
    return null;
  }


  void _submit() {
    // if there is no error text
    if (_eText == null) {
      // notify the parent widget via the onSubmit callback
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passController.text)
          .then((value) {
        print("Created New Account");
        var user = FirebaseAuth.instance.currentUser?.uid;
        userid = user.toString();
        useremail = _emailController.text.toString();
        username = _userController.text.toString();
        writeData();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => StartScreen()));
      }).onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255,188,184,253)),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/bkg.png'),
                fit: BoxFit.fill,

              )),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 420, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 280,
                  height: 71,
                  child: TextField(
                    // use this to control the text field
                    controller: _userController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Color.fromARGB(255,142,142,147)),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Color.fromARGB(255,142,142,147), fontFamily: "Montserrat", fontWeight: FontWeight.w600),
                      errorText: _uText,
                      contentPadding: EdgeInsets.fromLTRB(28,20,0,20),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),),
                    ),
                    onChanged: (text) => setState(() => _text),
                  ),
                ),
                const SizedBox(

                  height: 10,
                ),
                Container(
                  width: 280,
                  height: 71,
                  child: TextField(
                    // use this to control the text field
                    controller: _emailController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Color.fromARGB(255,142,142,147)),
                    decoration: InputDecoration(
                      labelText: 'Email Id',
                      labelStyle: TextStyle(color: Color.fromARGB(255,142,142,147), fontFamily: "Montserrat", fontWeight: FontWeight.w600),
                      errorText: _eText,
                      contentPadding: EdgeInsets.fromLTRB(28,20,0,20),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),),
                    ),
                    onChanged: (text) => setState(() => _text),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 280,
                  height: 71,
                  child: TextField(
                    // use this to control the text field
                    controller: _passController,
                    cursorColor: Colors.white,
                    obscureText: true,
                    style: TextStyle(color: Color.fromARGB(255,142,142,147)),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                        color: Color.fromARGB(255,142,142,147),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color.fromARGB(255,142,142,147), fontFamily: "Montserrat", fontWeight: FontWeight.w600),
                      errorText: _pText,
                      contentPadding: EdgeInsets.fromLTRB(28,20,0,20),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,188,184,253), width: 2.2),
                        borderRadius: BorderRadius.circular(50.0),),
                    ),
                    onChanged: (text) => setState(() => _text),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 280,
                  height: 51,
                  child: ElevatedButton(
                    // only enable the button if the ext is not empty
                    onPressed: _passController.value.text.isNotEmpty
                        ? _submit
                        : null,
                    child: Text(
                      'Sign Up',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal, fontSize: 23, fontFamily: "Montserrat"),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,109,100,255)),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                  ),
                )
              ],
            ),
          ))),
    );
  }
}



