import 'package:flutter/material.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/models/list.dart';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/utils/my_navigator.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => new _ContactsState();
 }

class _ContactsState extends State<Contacts> {

  List<Lista> _lista = new List();

  void initState(){
    super.initState();
    loadCursos();
  }

  void loadCursos() async{
    var  contacts = await HttpHandler().fetchLista(Settings.cadenaCon+"wslista/getlista/"+Settings.iduser+"/"+Settings.token);
    setState(() {
          _lista.addAll(contacts);
        });
  }

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     appBar: AppBar(
       title: Text("Contactos"),
     ),
     body: ListView.builder(
       itemCount: _lista.length,
       itemBuilder: (BuildContext context, int index){
         return ListTile(
           title: Text(
             _lista[index].grupo.materia.name,
             style: //Theme.of(context).textTheme.headline,
                TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontFamily: 'Nunito'
                  )
           ),
           subtitle: Text(_lista[index].grupo.teacher.name + " " + _lista[index].grupo.teacher.father_lastname),
           leading: Column(
             children: <Widget>[
               CircleAvatar(
                 backgroundColor: Colors.orangeAccent,
                 radius: 18,
                 child: Text(
                   _lista[index].grupo.materia.name[0],
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
                Settings.toEmail = _lista[index].grupo.teacher.email;
                print(Settings.toEmail);
                MyNavigator.goToSendMail(context, "/sendMail");
                //SendMail().main(); 
              });
           },
         );
       },
     ),
   );
  }
}