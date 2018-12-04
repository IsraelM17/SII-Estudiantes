import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/models/list.dart';
import 'package:sii_patm/models/kardex.dart';
import 'package:sii_patm/models/studentMatter.dart';
import 'package:sii_patm/models/teacherGroup.dart';
import 'package:sii_patm/models/alumnos.dart';

class HttpHandler{

  static String nombre = "";
  Future<dynamic> getLogin(String url) async {

    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    Map<String, dynamic> user = json.decode(response.body);
    return json.decode(response.body);

  }

  /**
   * Carga datos de la lista. (Cursos que esta tomando el alumno y sus profesores)
   */
  Future<dynamic> getLista(String url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    return json.decode(response.body);
  }

  Future<List<Lista>> fetchLista(String url){
    return getLista(url).then((data) => data['lista'].map<Lista>((item) => new Lista.fromJson(item)).toList());
  }

  /**
   * Carga datos StudentMatter (Materia alumnos)
   */
  Future<dynamic> getStudentMatter(String url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    print(response.body);
    return json.decode(response.body);
  }

  Future<List<StudentMatter>> fetchStudentMatter(String url){
    return getStudentMatter(url).then((data) => data['studentmatter'].map<StudentMatter>((item) => new StudentMatter.fromJson(item)).toList());
  }

  /**
   * Carga datos del kardex
   */
  Future<dynamic> getKardex(String url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    return json.decode(response.body);
  }

  Future<List<Kardex>> fetchKardex(String url){
    return getKardex(url).then((data) => data['kardex'].map<Kardex>((item) => new Kardex.fromJson(item)).toList());
  }

  /**
   * Obtiene datos del studiante/teach que ha ingresado a la aplicación
   */
  Future<dynamic> getStudent(String url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    Settings.statusCode = response.statusCode;
    return response.body.toString();
  }

  Future cargaLista(url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});

    //Lista lista = new Lista.fromJson(json.decode(response.body));
    //print("---------------------->"+lista.periodo);
    print("---------------------->"+response.body);
  }

  /**
   * Actualizacion de datos
   */
  Future putStudent(String url, String data) async{
    print(data);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.put(url, headers: {'authorization': basicAuth, "Content-Type" : "application/json"}, body: data);
    print(response.statusCode);
    Settings.statusCode = response.statusCode;
  }

  Future postMatter(String url, String data) async{
    print(data);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.post(url, headers: {'authorization': basicAuth, "Content-Type" : "application/json"}, body: data);
    print(response.statusCode);
    Settings.statusCode = response.statusCode;
  }

  /**
   * Carga grupos del profesor. (Cursos que esta impartiendo)
   */
  Future<dynamic> getTeacherGroup(String url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    print(response.body);
    return json.decode(response.body);
  }

  Future<List<TeacherGroup>> fetchTeacherGroup(String url){
    return getTeacherGroup(url).then((data) => data['teachergroup'].map<TeacherGroup>((item) => new TeacherGroup.fromJson(item)).toList());
  }

  /**
   * Carga alumnos de acuerdo al grupo del profesor. (Cursos que esta impartiendo)
   */
  Future<dynamic> getAlumnos(String url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    print(response.body);
    return json.decode(response.body);
  }

  Future<List<Alumnos>> fetchAlumnos(String url){
    return getAlumnos(url).then((data) => data['alumno'].map<Alumnos>((item) => new Alumnos.fromJson(item)).toList());
  }

}