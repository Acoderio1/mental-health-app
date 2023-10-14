import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:m_health/database/database.dart';
import 'package:m_health/screens/loadingg.dart';
import 'package:m_health/screens/reset_password.dart';
import 'package:m_health/screens/signup_screen.dart';

import '../reusable_widgets/reusable_widget.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var _text = '';

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  String? get _eText {
    // at any time, we can get the text from _controller.value.text
    final text = _emailController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return '';
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
      return '';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    //if (!text.contains(RegExp(r'[!#$%&()*+,-./:;<=>?@[\]^_`{|}~]'))){
      //return 'Include special Character';
    //}
    //if (!text.contains(RegExp(r'[123456789]'))){
      //return 'Include Number';
    //}
    // return null if the text is valid
    return null;
  }


  void _submit() {
    // if there is no error text
    if (_pText == null) {
      // notify the parent widget via the onSubmit callback
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passController.text)
          .then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Loadinscreen()));
      }).onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, 30, 20, 0),
            child: Column(
              children: <Widget>[
                Container(
                  width: 381,
                  height: 324,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  height: 71,
                  child:
                  TextField(
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
                  height: 71,
                  width: 300,
                  child:
                  TextField(
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
                forgetPassword(context),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,20,0,0),
                  child: SizedBox(
                    height: 51,
                    width: 300,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                      child: ElevatedButton(
                        // only enable the button if the text is not empty
                        onPressed: _passController.value.text.isNotEmpty
                            ? _submit
                            : null,
                        child: Text(
                          'Sign In',
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
                  ),
                ),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column signUpOption() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 44),
            const Text("Don't have account?",
                style: TextStyle(color: Color.fromARGB(255,142,142,147), fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),

            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()));
              },
              child: const Text(
                " Sign Up",
                style: TextStyle(color: Color.fromARGB(255, 99, 87, 255), fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
              ),
            )
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("or connect with",
                style: TextStyle(color: Color.fromARGB(255,142,142,147), fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Container(
              width: 37,
              height: 37,
              margin: const EdgeInsets.fromLTRB(60,30,50,0),
              child: Image.asset('assets/apple.png'),
            ),
            Container(
              width: 33,
              height: 33,
              margin: const EdgeInsets.fromLTRB(0,34,60,0),
              child: Image.asset('assets/google.png'),

            ),
            Container(
              width: 33,
              height: 33,
              margin: const EdgeInsets.fromLTRB(0,32,60,0),
              child: Image.asset('assets/facebook.png'),
            ),
          ],
        ),

        Container(
          padding: EdgeInsets.fromLTRB(0,36,0,0),
          child: Text("Page",
            textAlign: TextAlign.center, style: TextStyle(fontFamily: "Montserrat", fontSize: 12,fontWeight: FontWeight.w500, color: Color.fromARGB(255,142,142,147)),),
        )
      ],

    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(0,0,60,5),
      height: 35,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Color.fromARGB(255, 99, 87, 255), fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}


