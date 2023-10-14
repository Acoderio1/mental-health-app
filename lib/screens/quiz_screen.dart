import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:m_health/screens/finalquiz_screen.dart';

class PhqScreen extends StatefulWidget {
  const PhqScreen({Key? key}) : super(key: key);

  @override
  _PhqScreenState createState() => _PhqScreenState();
}

class _PhqScreenState extends State<PhqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(        extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 196, 144, 228),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10,0,10,0),
              child: Column(
                children: [
                  Text("PHQ8",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 68,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text("Scores of 5, 10, 15, and 20 represent cut points for mild, moderate, moderately severe and severe depressionrespectively. Sensitivity are identical to the PHQ-9.",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    width: 267,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const PhqquizScreen()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,181,222,255)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),


                      child: Text("Start",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 23, fontFamily: "Montserrat"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QadScreen extends StatefulWidget {
  const QadScreen({Key? key}) : super(key: key);

  @override
  _QadScreenState createState() => _QadScreenState();
}

class _QadScreenState extends State<QadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(        extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 196, 144, 228),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10,0,10,0),
              child: Column(
                children: [
                  Text("GAD7",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 68,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text("Scores of 5, 10, 15, and 20 represent cut points for mild, moderate, moderately severe and severe depressionrespectively. Sensitivity are identical to the PHQ-9.",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    width: 267,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const QadquizScreen()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,181,222,255)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),


                      child: Text("Start",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 23, fontFamily: "Montserrat"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}














