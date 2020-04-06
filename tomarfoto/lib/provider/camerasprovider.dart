import 'dart:async';
import '../main.dart';
import '../provider/providerConfig.dart';
import 'package:http/http.dart' as http;





Future enviarImagenn(String filename) async {
  String tenant = PaginaMain.user.getcorreo();
  String url = '${ConfigPaths.pathServicios}/contar/'+tenant; 
  var request = http.MultipartRequest('POST', Uri.parse(url));

  request.files.add(
    await http.MultipartFile.fromPath(
      'image',
      filename
    )
  );
  print('envia...');
   var res = await request.send();
  print('envió codigo:${res.statusCode}');
  if (res.statusCode==200){
  return res;
  }else
  {
    var response = await http.Response.fromStream(res);
    throw Exception('${res.statusCode}, => ${response.body}');
  }
}

