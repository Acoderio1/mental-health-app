import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255,99,87,255)),
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
              child: Container(
                child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 420, 20, 0),
            child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 51,
                      width: 284,
                    child: reusableTextField("Email Id", Icons.person_outline, false,
                        _emailTextController,""),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 51,
                      width: 284,
                    child: firebaseUIButton(context, "Reset Password", () {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailTextController.text)
                          .then((value) => Navigator.of(context).pop());
                    }),
                  )
                ],
            ),
          ),
              ))),
    );
  }
}
