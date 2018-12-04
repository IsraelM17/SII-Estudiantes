import 'package:flutter/material.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/models/alumnos.dart';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/utils/my_navigator.dart';

class ListAlumnos extends StatefulWidget {
  @override
  _ListAlumnosState createState() => new _ListAlumnosState();
 }

class _ListAlumnosState extends State<ListAlumnos> {

  //List<TeacherGroup> _lista = new List();
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
             style: //Theme.of(context).textTheme.headline,
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
                print("Hola mundito");
                //Settings.teacherMail = _lista[index].grupo.teacher.email;
                //print(Settings.teacherMail);
                //MyNavigator.goToSendMail(context, "/sendMail");
                //SendMail().main(); 
              });
           },
         );
       },
     ),
   );
  }
}