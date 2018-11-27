import 'package:flutter/material.dart';
import 'package:sii_patm/pages/DashBoardFolder/kardexList.dart';
import 'package:sii_patm/pages/DashBoardFolder/cursos.dart';
import 'package:sii_patm/pages/DashBoardFolder/actividadExtra.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/models/student.dart';
import 'dart:convert';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => new _DashBoardState();
 }

class _DashBoardState extends State<DashBoard>  with SingleTickerProviderStateMixin{
  
  TabController tabController;
  static String nameStudent = "";
  static int idstudent;
  static Student student;

  Map<String, dynamic> studentMap;

  @override
  void initState(){
    super.initState();
    //validate();
    //loadJson();
    loadStudent(Settings.cadenaCon+"wsstudent/getStudent/"+Settings.user+"/"+Settings.token);
    tabController = new TabController(length: 3, vsync: this);
  }


  ListView listView = new ListView(
    children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: Text(nameStudent),
        currentAccountPicture: GestureDetector(
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://pickaface.net/gallery/avatar/cavneb565b7bd529c1d.png'),
          ),
          onTap: () => print("Cuenta"),
        ),
        otherAccountsPictures: <Widget>[
          GestureDetector(
            child: CircleAvatar(
              child: Image.asset('assets/itclogo.png'),
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
      ListTile(
        leading: Icon(Icons.person),
        title: Text("Perfil"),
      ),
      ListTile(
        leading: Icon(Icons.more),
        title: Text("Inscribir Materia"),
      ),
      ListTile(
        leading: Icon(Icons.contacts),
        title: Text("Contactos"),
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("Cerrar Sesión"),
      ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text("A cerca de "),
      ),
    ],
  );

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("SII"),
        backgroundColor: Colors.green,
      ),

      drawer: Drawer(
        child: listView,
      ),

      body: TabBarView(
        children: <Widget>[
          ListaCursos(),
          KardexList(),
          ActividadExtra(),
        ],
        controller:  tabController,
      ),

      bottomNavigationBar: Material(
        color: Colors.green,
        child: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.list),
              text: "Calificaciones",
            ),
            Tab(
              icon: Icon(Icons.accessibility),
              text: "Kardex",
            ),
            Tab(
              icon: Image.asset('assets/iconos/futbol.png'),
              text: "Actividades Ext.",
            ),
          ],
          controller: tabController,
        ),
      ),
    );
  }

  void validate() async{
    var student = HttpHandler().getStudent(Settings.cadenaCon+"wsstudent/getStudent/"+Settings.user+"/"+Settings.token);
    
  }

  Future loadStudent(String url) async {
    String jsonString = await HttpHandler().getStudent(url);
    final jsonRsponse = json.decode(jsonString);
    student = new Student.fromJson(jsonRsponse);
    nameStudent = student.name;
    print(nameStudent);
    return student;
  }

}