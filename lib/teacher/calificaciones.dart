import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/connection/HttpHandler.dart';

class Calificaciones extends StatefulWidget {
  @override
  _CalificacionesState createState() => new _CalificacionesState();
 }

class _CalificacionesState extends State<Calificaciones>  with SingleTickerProviderStateMixin{

  TextEditingController controllerC1  = new TextEditingController();
  TextEditingController controllerC2  = new TextEditingController();
  TextEditingController controllerC3  = new TextEditingController(); 
  TextEditingController controllerC4  = new TextEditingController();
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
    controllerC1.text = "0";
    controllerC2.text = "0";
    controllerC3.text = "0";
    controllerC4.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    final logo =UserAccountsDrawerHeader(
          accountEmail: Text(Settings.toEmail),
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
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        suffixText: 'Cal. I'
      ),
      controller: controllerC1,
      
    );

    final txtCareer = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
        suffixText: 'Cal. II'
      ),
      controller: controllerC2,
    );

    final txtPhone = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        //counterText: 'Telefono',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
        suffixText: 'Cal. III'
      ),
      controller: controllerC3,
    );

    final txtAddress = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
        suffixText: 'Cal. IV',
      ),
      controller: controllerC4,
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
        title: Text("Calificaciones"),
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

    String data = jsonEncode({
	    "idgroup": Settings.idgroup,
      "idstudent": Settings.idStudent,
      "periodo": "AGO-DIC",
      "c1": controllerC1.text,
      "c2": controllerC2.text,
      "c3": controllerC3.text,
      "c4": controllerC4.text
    });
    
    String url = Settings.cadenaCon+"wslista/putLista/"+Settings.token;
    print("********** "+data);
    HttpHandler().putLista(url,data);
    if(Settings.statusCode == 200){
      _showSnackBar();
    }

  }

}