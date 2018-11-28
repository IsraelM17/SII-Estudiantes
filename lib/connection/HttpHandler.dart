import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sii_patm/utils/settings.dart';
import 'package:sii_patm/models/list.dart';
import 'package:sii_patm/models/kardex.dart';
import 'package:sii_patm/models/student.dart';

class HttpHandler{

  static String nombre = "";
  Future<dynamic> getLogin(String url) async {

    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    Map<String, dynamic> user = json.decode(response.body);
    return json.decode(response.body);

  }

  Future<dynamic> getLista(String url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    print(response.body);
    return json.decode(response.body);
  }

  Future<List<Lista>> fetchLista(String url){
    return getLista(url).then((data) => data['lista'].map<Lista>((item) => new Lista.fromJson(item)).toList());
  }

  Future<dynamic> getKardex(String url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    return json.decode(response.body);
  }

  Future<List<Kardex>> fetchKardex(String url){
    return getKardex(url).then((data) => data['kardex'].map<Kardex>((item) => new Kardex.fromJson(item)).toList());
  }

  Future<dynamic> getStudent(String url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});
    return response.body.toString();
  }

  Future cargaLista(url) async{
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(Settings.username+":"+Settings.password));
    http.Response response = await http.get(url, headers: {'authorization': basicAuth});

    //Lista lista = new Lista.fromJson(json.decode(response.body));
    //print("---------------------->"+lista.periodo);
    print("---------------------->"+response.body);
  }

}