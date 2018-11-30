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
          accountName: Text("pruebita"),
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
        labelText: 'No. Control',
      ),
      controller: controllerNocControl,
      
    );

    final txtCareer = TextFormField(
      autofocus: false,
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
        labelText: 'Carrera',
      ),
      controller: controllerCarrer,
    );

    final txtPhone = TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        //counterText: 'Telefono',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
        labelText: 'Telefono',
      ),
      controller: controllerPhone,
    );

    final txtAddress = TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
        labelText: 'Direccion',
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
            SizedBox(height: 8.0),
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
    String data = jsonEncode({
      "email": "14030625@ITCELAYA.EDU.MX",
      "father_lastname": "MORENO",
      "idcareer": "0",
      "idstudent": "8",
      "mother_lastname": "CASILLAS",
      "name": "SERGIO ISRAEL",
      "nocontrol": "14030625",
      "address" : controllerAddress.text,
      "phone" : controllerPhone.text
    });
    print("********** "+data);
    HttpHandler().putStudent(Settings.cadenaCon+"wsstudent/putStudent/"+Settings.token,data);
    if(Settings.statusCode == 200)
      Navigator.pop(context);
  }
}