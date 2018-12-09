import 'package:flutter/material.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/models/studentMatter.dart';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/utils/my_navigator.dart';
import 'dart:convert';

class PendingMatters extends StatefulWidget {
  @override
  _PendingMattersState createState() => new _PendingMattersState();
 }

enum DialogAction{
  yes, 
  no
}

class _PendingMattersState extends State<PendingMatters> {
  List<StudentMatter> _lista = new List();
  String url = Settings.cadenaCon+"wsstudentmatter/getStudentMatter/"+Settings.iduser+"/"+Settings.semester+"/"+Settings.token;
  
  void initState(){
    super.initState();
    print(url);
    loadCursos();
  }

  void loadCursos() async{
    var  matters = await HttpHandler().fetchStudentMatter(url);
    setState(() {
          _lista.addAll(matters);
        });
  }

  void _showAlert(String idgroup){
    AlertDialog dialog = new AlertDialog(
      content: Text("¿Seguro que desea cargar esta materia?"),
      actions: <Widget>[
        FlatButton(onPressed: () {_alertResult(DialogAction.yes, idgroup);},
        child: Text("Aceptar"),),
        FlatButton(onPressed: () {_alertResult(DialogAction.no, "");}, 
        child: Text("Cancelar"),),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void _alertResult(DialogAction action, String idgroup){
    if(action.toString() == "DialogAction.yes"){
      sendData(idgroup);
      Navigator.of(context).pop();
    }
    else
      Navigator.of(context).pop();
  }

  void sendData(String idgroup) async{
    String data = jsonEncode({
      "idstudent": Settings.iduser,
      "idgroup": idgroup,
      "period": "AGO-DIC",
    });
    print("********** "+data);
    HttpHandler().postMatter(Settings.cadenaCon+"wslista/postLista/"+Settings.token,data);
    if(Settings.statusCode == 200){
      print(Settings.statusCode);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     appBar: AppBar(
       title: Text("Cargar Materias"),
     ),
     body: ListView.builder(
       itemCount: _lista.length,
       itemBuilder: (BuildContext context, int index){
         return ListTile(
           title: Text(
             _lista[index].name,
             style: //Theme.of(context).textTheme.headline,
                TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontFamily: 'Nunito'
                  )
           ),
           subtitle: Text("Semestre: " + _lista[index].semester.toString()),
           leading: Column(
             children: <Widget>[
               CircleAvatar(
                 backgroundColor: Colors.orangeAccent,
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
               print(_lista[index].idgroup);
                _showAlert(_lista[index].idgroup); 
              });
           },
         );
       },
     ),
   );
  }
}