import 'package:flutter/material.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/models/list.dart';
import 'package:sii_patm/utils/settings.dart';

class ListaCursos extends StatefulWidget {
  @override
  _ListaCursosState createState() => new _ListaCursosState();
 }
class _ListaCursosState extends State<ListaCursos> {

  List<Lista> list = new List();

  @override
  void initState(){
    super.initState();
    loadCursos();
  }

  void loadCursos() async{
    var  movies = await HttpHandler().fetchLista(Settings.cadenaCon+"wslista/getlista/"+Settings.iduser+"/"+Settings.token);
    setState(() {
          list.addAll(movies);
        });
  }

  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Materia"),
          numeric: false,
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text("C1"),
          numeric: false
        ),
         DataColumn(
          label: Text("C2"),
          numeric: false,
          tooltip: "To display last name of the Name",
        ),
        DataColumn(
          label: Text("C3"),
          numeric: false,
          tooltip: "To display last name of the Name",
        ),
        DataColumn(
          label: Text("C4"),
          numeric: false,
          tooltip: "To display last name of the Name",
        ),
      ],
      rows: list.map((name) => DataRow(
              cells: [
              DataCell(
                Text(name.grupo.materia.name),
                showEditIcon: false,
                placeholder: false,
              ),
              DataCell(
                Text("80"),
                showEditIcon: false,
                placeholder: false
              ),
              DataCell(
                Text("90"),
                showEditIcon: false,
                placeholder: false,
              ),
              DataCell(
                Text("90"),
                showEditIcon: false,
                placeholder: false,
              ),
              DataCell(
                Text("90"),
                showEditIcon: false,
                placeholder: false,
              ),
            ],
          ),
          )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Container(
        child: bodyData(),
    );
  }

}

/*
@override
  Widget build(BuildContext context) {
   return new Container(
     child: ListView.builder(
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
         );
       },
     ),
   );
  }
*/