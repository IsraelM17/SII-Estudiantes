import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sii_patm/utils/my_navigator.dart';

void main(){
  runApp(new MaterialApp(
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget{
  static String tag = 'splashscreen';
  @override 
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => MyNavigator.goLogin(context));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(decoration:  BoxDecoration(color: Colors.white),),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 150.0,
                        child: Image.asset('assets/iconos/tecnmlogo.png')
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(backgroundColor: Colors.greenAccent,),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "by: Israel Moreno",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:  18.0,
                        color: Colors.black54,
                        fontFamily: 'Nunito'
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}