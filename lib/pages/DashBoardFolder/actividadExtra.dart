import 'package:flutter/material.dart';
import 'package:sii_patm/models/kardex.dart';
import 'package:sii_patm/connection/HttpHandler.dart';
import 'package:sii_patm/utils/settings.dart';


class ActividadExtra extends StatefulWidget {
  @override
  _ActividadExtraState createState() => _ActividadExtraState();
}

class _ActividadExtraState extends State<ActividadExtra> {

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
          label: Text("Actividad"),
          numeric: false,
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text("Situacion"),
          numeric: false
        ),
         DataColumn(
          label: Text("Anio"),
          numeric: false,
          tooltip: "To display last name of the Name",
        ),
      ],
      rows: list
          .map(
            (name) => DataRow(
                  cells: [
                    DataCell(
                      Text("Natacion"),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text("Acreditado"),
                      showEditIcon: false,
                      placeholder: false
                    ),
                    DataCell(
                      Text("2018"),
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