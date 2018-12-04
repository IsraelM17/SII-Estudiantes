import 'package:flutter/material.dart';
import 'package:sii_patm/utils/my_navigator.dart';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String noControl  = "";
  String password   = "";
  bool  acceso       = false;
  final TextEditingController noControlController = new TextEditingController();
  final TextEditingController passwordController  = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final snackBar = new SnackBar(
        content: Text("Usuario y/o contraseña invalidos"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.redAccent
    );
    //How to display Snackbar ?
    _scaffoldKey.currentState.showSnackBar(snackBar);
}

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 90.0,
        child: Image.asset("assets/iconos/itclogo.png")
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'No. Control',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: noControlController,
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contrasenia',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
      ),
      controller: passwordController,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            validate();
            /*
            if(acceso){
              MyNavigator.goDashBoard(context);
            }
            else{
              _showSnackBar();
            }
            */
          },
          color: Colors.green,
          child: Text('Ingresar', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        '¿Haz olvidado la contrasenia?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );


    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ]
        ),
      ),
    );
  }

  void validate() async{
    
    Map<String, dynamic> user = await HttpHandler().getLogin(Settings.cadenaCon+"wsuser/validate/"+noControlController.text+"/"+passwordController.text);
    if(user['token'] != "Acceso denegado" && user['token'] != "java.lang.NullPointerException")
    {
      Settings.role = user['role'];
      if(user['role'] == "1"){
        Settings.token          = user['token'];
        Settings.noControl      = noControlController.text;
        Settings.iduser         = user['idestudent'];
        Settings.passwordStudent= passwordController.text; 
        acceso = true;
        MyNavigator.goDashBoard(context);
      } 
      else if(user['role'] == "2"){
        Settings.iduser     = user['idteacher'];
        Settings.token      = user['token'];
        Settings.noControl  = noControlController.text;
        print(Settings.iduser);
        MyNavigator.goToDashBoardTeach(context);
      }
    }
    else{
      print("Usuario y/o contraseña invalidos");
      acceso = false;
      _showSnackBar();
    }
  }

}