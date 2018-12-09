import 'package:flutter/material.dart';
import 'package:sii_patm/pages/SplashScreen.dart';
import 'package:sii_patm/pages/dashboard.dart';
import 'package:sii_patm/pages/MenuDrawer/contacts.dart';
import 'package:sii_patm/pages/MenuDrawer/profile.dart';
import 'package:sii_patm/pages/MenuDrawer/mail.dart';
import 'package:sii_patm/pages/MenuDrawer/pendingMattters.dart';
import 'package:sii_patm/dashboardTeacher.dart';
import 'package:sii_patm/teacher/listAlumnos.dart';
import 'package:sii_patm/teacher/calificaciones.dart';

void main() => runApp(MyApp());

var routes = <String, WidgetBuilder>{
  "/dashboard": (BuildContext context) => DashBoard(),
  "/contacts": (BuildContext context) => Contacts(),
  "/updateStudent": (BuildContext context) => Profile(),
  "/sendMail": (BuildContext context) => SendEmail(),
  "/pendingMatter": (BuildContext context) => PendingMatters(),
  "/dashboardteach": (BuildContext context) => DashBoardTeach(),
  "/alumnos": (BuildContext context) => ListAlumnos(),
  "/calificaciones": (BuildContext context) => Calificaciones()
};

class MyApp extends StatelessWidget {
  /*
  final routes = <String, WidgetBuilder>{
    SplashScreen.tag: (context) => SplashScreen(),
  };
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SII',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Nunito',
      ),
      home: SplashScreen(),
      routes: routes,
    );
  }
}
