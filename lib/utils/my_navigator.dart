import 'package:flutter/material.dart';
import 'package:sii_patm/pages/login.dart';
class MyNavigator {
  static void goLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new LoginPage()));
  }

  static void goDashBoard(BuildContext context){
    Navigator.pushNamed(context, "/dashboard");
  }

  static void goContacts(BuildContext context, String route){
    Navigator.pushNamed(context, route);
  }
  /*
  static void goToIntro(BuildContext c  ontext) {
    Navigator.pushNamed(context, "/intro");
  }
  */
}