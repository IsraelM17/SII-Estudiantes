import 'package:http/http.dart';
import 'dart:convert';

class Connection {
   int statusCode = 0;
   validate(String cadena) async{
    String username = 'root';
    String password = 'root';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print(basicAuth);

    Response r = await get('http://192.168.100.254:8080/SII-WSPATM/api/'+cadena,
        headers: {'authorization': basicAuth});
    statusCode += r.statusCode;
    if(statusCode == 200)
      print("Excelente");
    print(r.body);
    print("Accediste al recurso "+cadena);
  }

  


}