import 'package:flutter/material.dart';
import 'package:sii_patm/pages/login.dart';
import 'package:sii_patm/pages/dashboard.dart';
class MyNavigator {
  static void goLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new LoginPage()));
  }

  static void goDashBoard(BuildContext context){
    Navigator.pushNamed(context, "/dashboard");
  }
  /*
  static void goToIntro(BuildContext c  ontext) {
    Navigator.pushNamed(context, "/intro");
  }
  */
}