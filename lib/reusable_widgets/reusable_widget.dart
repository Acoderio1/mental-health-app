import 'package:flutter/material.dart';
import 'package:m_health/utils/color_utils.dart';
import '../utils/color_utils.dart';


Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

bool val = false;
String? validate(String value) {
  if (!(value.length > 5) && value.isNotEmpty) {
    return "Too short";
  }
  if (value.isEmpty){
    return "Can't be empty";
  }
  return null;
}


TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, String value) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: hexStringToColor("8E8E93")),
    decoration: InputDecoration(
      suffixIcon: Icon(
        icon,
        color: hexStringToColor("8E8E93"),
      ),
      contentPadding: EdgeInsets.fromLTRB(28,20,0,20),
      labelText: text,
      labelStyle: TextStyle(color: hexStringToColor("8E8E93"), fontFamily: "Montserrat", fontWeight: FontWeight.w600),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: hexStringToColor("BCB8FD"), width: 2.2),
        borderRadius: BorderRadius.circular(50.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: hexStringToColor("BCB8FD"), width: 2.2),
        borderRadius: BorderRadius.circular(50.0),

      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
          onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255,109,100,255)),
          shadowColor: MaterialStateProperty.all<Color>(Colors.white24),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),


      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 23, fontFamily: "Montserrat"),
      ),

    ),
  );
}
