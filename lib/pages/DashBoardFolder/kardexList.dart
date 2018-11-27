import 'package:flutter/material.dart';
import 'package:sii_patm/models/kardex.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/utils/settings.dart';

class KardexList extends StatefulWidget {
  @override
  _KardexListState createState() => new _KardexListState();
 }
class _KardexListState extends State<KardexList> {

  List<Kardex> list = new List();

  @override
  void initState(){
    super.initState();
    loadKardex();
  } 

  void loadKardex() async{
    var kardex = await HttpHandler().fetchKardex(Settings.cadenaCon+"wskardex/getkardex/"+Settings.iduser+"/"+Settings.token);
    setState(() {
          list.addAll(kardex);
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
          label: Text("Semestre"),
          numeric: false
        ),
         DataColumn(
          label: Text("Calificacion"),
          numeric: false,
          tooltip: "To display last name of the Name",
        ),
      ],
      rows: list.map((name) => DataRow(
              cells: [
              DataCell(
                Text(name.matter.name),
                showEditIcon: false,
                placeholder: false,
              ),
              DataCell(
                Text(name.semester),
                showEditIcon: false,
                placeholder: false
              ),
              DataCell(
                Text(name.qualification),
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