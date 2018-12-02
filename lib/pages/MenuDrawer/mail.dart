import 'package:flutter/material.dart';
import 'package:sii_patm/connection/sendmail.dart';
import 'package:sii_patm/utils/settings.dart';

class SendEmail extends StatefulWidget {
  @override
  _SendEmailState createState() => new _SendEmailState();
 }

class _SendEmailState extends State<SendEmail> with SingleTickerProviderStateMixin{

  TextEditingController controllerFrom    = new TextEditingController();
  TextEditingController controllerSubject = new TextEditingController();
  TextEditingController controllerContent = new TextEditingController(); 
  GlobalKey<ScaffoldState> globalKey      = new GlobalKey();

  @override
  void initState(){
    super.initState();
    controllerFrom.text = Settings.teacherMail;
  }

  showSnackBar(){
    final snackBar = new SnackBar(
      content: Text("Su mensaje ha sido enviado"),
      backgroundColor: Colors.blueAccent,
      duration: Duration(seconds: 2),
    );
    globalKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {

  final from = TextFormField(
    autofocus: false,
    enabled: false,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
    ),
    controller: controllerFrom,
  );

  final subject = TextFormField(
    autofocus: false,
    enabled: true,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      hintText: 'Asunto'
    ),
    controller: controllerSubject,
  );

  final contenido = TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)), fillColor: Colors.green,
      ),
      maxLines: 10,
      controller: controllerContent,
    );
  
    return new Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text("Enviar Correo"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            from,
            SizedBox(height: 10.0),
            subject,
            SizedBox(height: 10.0),
            contenido
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.send),
        label: const Text('Enviar'),
        onPressed: () {
          SendMail().main(controllerFrom.text, controllerSubject.text, controllerContent.text);
          showSnackBar();
        },
      ),
    );
  }
  //final btnSend = 
}