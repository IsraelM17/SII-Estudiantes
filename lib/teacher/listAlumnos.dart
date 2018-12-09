import 'package:flutter/material.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/models/alumnos.dart';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/utils/my_navigator.dart';

class ListAlumnos extends StatefulWidget {
  @override
  _ListAlumnosState createState() => new _ListAlumnosState();
 }

enum DialogAction{
  email, 
  calificacion
}

class _ListAlumnosState extends State<ListAlumnos> {

  String email;

  List<Alumnos> _lista = new List();
  void initState(){
    super.initState();
    loadCursos();
  }

  void loadCursos() async{
    var  data = await HttpHandler().fetchAlumnos(Settings.cadenaCon+"wsalumno/getAlumno/"+Settings.iduser+"/"+Settings.keymatter+"/"+Settings.token);
    setState(() {
          _lista.addAll(data);
        });
  }

  void _showAlert(){
    AlertDialog dialog = new AlertDialog(
      content: Text("Elija una acción"),
      actions: <Widget>[
        FlatButton(onPressed: () {_alertResult(DialogAction.email);},
        child: Text("Enviar email"),),
        FlatButton(onPressed: () {_alertResult(DialogAction.calificacion);}, 
        child: Text("Evaluar"),),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void _alertResult(DialogAction action){
    if(action.toString() == "DialogAction.email"){
      Settings.toEmail = email;
      MyNavigator.goToSendMail(context, "/sendMail");
    }
    else if(action.toString() == "DialogAction.calificacion"){
      Settings.toEmail = email;
      MyNavigator.goToCalifciaciones(context);
    }
  }

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     appBar: AppBar(
       title: Text("Alumnos"),
     ),
     body: ListView.builder(
       itemCount: _lista.length,
       itemBuilder: (BuildContext context, int index){
         return ListTile(
           title: Text(
             _lista[index].name + " "+_lista[index].father_lastname,
             style: 
                TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontFamily: 'Nunito'
                  )
           ),
           subtitle: Text(_lista[index].email),
           leading: Column(
             children: <Widget>[
               CircleAvatar(
                 backgroundColor: Colors.amberAccent,
                 radius: 18,
                 child: Text(
                   _lista[index].name[0],
                   style: TextStyle(
                     fontSize: 13.0,
                     color: Colors.white
                   ),
                 ),
               ),
             ],
           ),
           onTap: (){
             setState(() {
               email = _lista[index].email;
               Settings.idgroup         = _lista[index].idgroup;
               Settings.idStudent       = _lista[index].idstudent;
               Settings.nameStudent     = _lista[index].name;
               Settings.father_lastname = _lista[index].father_lastname;
               Settings.mother_lastname = _lista[index].mother_lastname;
                _showAlert();
              });
           },
         );
       },
     ),
   );
  }
}