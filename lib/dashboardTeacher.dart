import 'package:flutter/material.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/models/teacherGroup.dart';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/utils/my_navigator.dart';
import 'package:sii_patm/models/teacher.dart';
import 'dart:convert';

class DashBoardTeach extends StatefulWidget {
  @override
  _DashBoardTeachState createState() => new _DashBoardTeachState();
 }

class _DashBoardTeachState extends State<DashBoardTeach> with SingleTickerProviderStateMixin{

  List<TeacherGroup> _lista = new List();
  Teacher teacher;

  void initState(){
    super.initState();
    loadCursos();
    loadTeacher();
  }

  void loadCursos() async{
    var  data = await HttpHandler().fetchTeacherGroup(Settings.cadenaCon+"wsteachergroup/getTeacherGroup/"+Settings.iduser+"/"+Settings.token);
    setState(() {
          _lista.addAll(data);
        });
  }

  ListTile _getItem(Icon icon, String title, String route){
    return ListTile(
      leading: icon,
      title: new Text(title),
      onTap: (){
        setState(() {
          MyNavigator.goMenuOptions(context, route);
        });
      },
    );
  }

  Drawer getDrawer(BuildContext context){
    ListView listView = new ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text(Settings.noControl+"@itcelaya.edu.mx"),
          accountName: Text(Settings.nameTeacher),
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
              //onTap: ,
            ),
          ],
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://cdn-images-1.medium.com/max/800/1*8_sKMUCcMPka4fBzmcWuhA.png'),
              fit: BoxFit.fill
            )
          ),
        ),
        _getItem(new Icon(Icons.person), "Perfil", "/updateStudent"),
        _getItem(new Icon(Icons.exit_to_app), "Cerrar sesión", "route"),
        _getItem(new Icon(Icons.info), "Acerca de","route"),
      ],
    );
    return new Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     appBar: AppBar(
       title: Text("SII-Profesores"),
     ),
     drawer: getDrawer(context),
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
           subtitle: Text(_lista[index].name),
           leading: Column(
             children: <Widget>[
               CircleAvatar(
                 backgroundColor: Colors.blueAccent,
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
                Settings.keymatter = _lista[index].keymatter;
                MyNavigator.goToAlumnos(context);
              });
           },
         );
       },
     ),
   );
  }

  Future loadTeacher() async {
    String jsonString = await HttpHandler().getStudent(Settings.cadenaCon+"wsteacher/getTeacher/"+Settings.iduser+"/"+Settings.token);
    final jsonRsponse = json.decode(jsonString);
    print(jsonRsponse);
    teacher = new Teacher.fromJson(jsonRsponse);
    
    setState(() {
          Settings.noControl  = teacher.nocontrol;
          Settings.nameTeacher= teacher.name;
          Settings.career     = "Sistemas Y computación";
          Settings.father_lastname = teacher.father_lastname;
          Settings.mother_lastname = teacher.mother_lastname;
          Settings.address    = teacher.address;
          Settings.phone      = teacher.phone;
          print(Settings.address + " "+ Settings.phone);
        });

    return Teacher;
  }

}