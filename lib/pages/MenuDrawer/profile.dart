import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/connection/HttpHandler.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
 }

class _ProfileState extends State<Profile>  with SingleTickerProviderStateMixin{

  TextEditingController controllerNocControl  = new TextEditingController();
  TextEditingController controllerCarrer      = new TextEditingController();
  TextEditingController controllerPhone       = new TextEditingController(); 
  TextEditingController controllerAddress     = new TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey   = new GlobalKey<ScaffoldState>();

  _showSnackBar(){
    final snackBar = SnackBar(
      content: Text("Datos Actualizados"),
      backgroundColor: Colors.blueAccent,
      duration: Duration(seconds: 2),
    );

  _globalKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState(){
    super.initState();
    controllerNocControl.text = Settings.noControl;
    controllerCarrer.text     = Settings.career;
    controllerPhone.text      = Settings.phone;
    controllerAddress.text    = Settings.address;
  }

  @override
  Widget build(BuildContext context) {
    final logo =UserAccountsDrawerHeader(
          accountEmail: Text(Settings.noControl+"@itcelaya.edu.mx"),
          accountName: Text(Settings.nameStudent),
          currentAccountPicture: GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://pickaface.net/gallery/avatar/cavneb565b7bd529c1d.png'),
            ),
            onTap: () => print("Cuenta"),
          ),
          otherAccountsPictures: <Widget>[
            GestureDetector(
              child: CircleAvatar(
                child: Image.asset('assets/iconos/itclogo.png'),
              ),
            ),
          ],
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://cdn-images-1.medium.com/max/800/1*8_sKMUCcMPka4fBzmcWuhA.png'),
              fit: BoxFit.fill
            )
          ),
        );

  final txtNoControl = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        suffixText: 'No. Control'
      ),
      controller: controllerNocControl,
      
    );

    final txtCareer = TextFormField(
      autofocus: false,
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
        suffixText: 'Carrera'
      ),
      controller: controllerCarrer,
    );

    final txtPhone = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        //counterText: 'Telefono',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
        suffixText: 'Telefono'
      ),
      controller: controllerPhone,
    );

    final txtAddress = TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
        suffixText: 'Direccion',
      ),
      controller: controllerAddress,
    );

    final btnActualizar = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.orangeAccent.shade400,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            sendData();
          },
          color: Colors.orange.shade600,
          child: Text('Actualizar', style: TextStyle(color: Colors.white)),
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: Center(
        child: ListView(
          //shrinkWrap: true,
          //padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 35.0),
            txtNoControl,
            SizedBox(height: 10.0),
            txtCareer,
            SizedBox(height: 8.0,),
            txtPhone,
            SizedBox(height: 8.0,),
            txtAddress,
            SizedBox(height: 15.0),
            btnActualizar,
          ],
        ),
      ),
    );
  }

  void sendData() async{
    String data;
    String url;
    if(Settings.role == "1"){
      data = jsonEncode({
        "email": Settings.noControl+"@itcelaya.edu.mx",
        "father_lastname": Settings.father_lastname,
        "idcareer": "0",
        "idstudent": Settings.iduser,
        "mother_lastname": Settings.mother_lastname,
        "name": Settings.name,
        "nocontrol": Settings.noControl,
        "address" : controllerAddress.text,
        "phone" : controllerPhone.text
      });
      url = Settings.cadenaCon+"wsstudent/putStudent/"+Settings.token;
    }
    else if(Settings.role == "2"){
      data = jsonEncode({
      "email": Settings.noControl+"@ITCELAYA.EDU.MX",
      "father_lastname": Settings.father_lastname,
      "iddepartment": "0",
      "idteacher": Settings.iduser,
      "mother_lastname": Settings.mother_lastname,
      "name": Settings.name,
      "nocontrol": Settings.noControl,
      "address" : controllerAddress.text,
      "phone" : controllerPhone.text
      });
      url = Settings.cadenaCon+"wsteacher/putTeacher/"+Settings.token;
    }
    print("********** "+data);
    HttpHandler().putStudent(url,data);
    if(Settings.statusCode == 200){
      Settings.phone = controllerPhone.text;
      Settings.address = controllerAddress.text;
      _showSnackBar();
    }
  }

}