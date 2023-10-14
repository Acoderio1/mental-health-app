import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:m_health/screens/finalquiz_screen.dart';
import 'package:m_health/screens/startquiz.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _isdisables = true;
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
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text('Age group',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                )),
            Container(
              padding: EdgeInsets.fromLTRB(10,0,10,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 181, 222, 255)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed:() => {Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const UnderageScreen()))},
                      child: Text('15 - 28',
                        style: TextStyle(
                            fontFamily: "Monsterrat",
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 172,
                    height: 67,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 181, 222, 255)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                      onPressed: () => {Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const OverageScreen()))},
                      child: Text("29 - 45",
                        style: TextStyle(
                            fontFamily: "Monsterrat",
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
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
    );
  }
}














