import 'package:flutter/material.dart';
import 'package:sii_patm/pages/DashBoardFolder/kardexList.dart';
import 'package:sii_patm/pages/DashBoardFolder/cursos.dart';
import 'package:sii_patm/pages/DashBoardFolder/actividadExtra.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/models/student.dart';
import 'package:sii_patm/utils/my_navigator.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
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
    loadStudent();
    tabController = new TabController(length: 3, vsync: this);
  }

  ListTile _getItem(Icon icon, String title, String route){
    return ListTile(
      leading: icon,
      title: new Text(title),
      onTap: (){
        setState(() {
          if(route == "carga"){
            FlutterPdfViewer.loadAsset('assets/pdf/CargaAcademica.pdf');
          }
          else{
            MyNavigator.goMenuOptions(context, route);
          }
        });
      },
    );
  }
  
  Drawer getDrawer(BuildContext context){
    ListView listView = new ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text(Settings.noControl+"@itcelaya.edu.mx"),
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
        _getItem(new Icon(Icons.picture_as_pdf), "Carga academica", "carga"),
        _getItem(new Icon(Icons.more), "Inscribir Materia", "/pendingMatter"),
        _getItem(new Icon(Icons.contacts), "Contactos", "/contacts"),
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
        title: Text("SII"),
        backgroundColor: Colors.green,
      ),

      drawer: Drawer(
        child: getDrawer(context),
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
    String student = await HttpHandler().getStudent(Settings.cadenaCon+"wsstudent/getStudent/"+Settings.nameStudent+"/"+Settings.token); 
  }

  Future loadStudent() async {
    String jsonString = await HttpHandler().getStudent(Settings.cadenaCon+"wsstudent/getStudent/"+Settings.iduser+"/"+Settings.token);
    final jsonRsponse = json.decode(jsonString);
    print(jsonRsponse);
    student = new Student.fromJson(jsonRsponse);
    
    setState(() {
          nameStudent = student.name;
          Settings.nameStudent = nameStudent + " " + student.father_lastname;
          Settings.career = student.career;
          Settings.noControl = student.nocontrol;
          Settings.address = student.address;
          Settings.phone = student.phone;
          Settings.noControl  = student.nocontrol;
          Settings.name       = student.name;
          Settings.father_lastname = student.father_lastname;
          Settings.mother_lastname = student.mother_lastname;
          Settings.semester = student.semester;
        });

    return student;
  }

}