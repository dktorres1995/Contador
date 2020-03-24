import 'dart:async';
import 'package:tomarfoto/provider/providerConfig.dart';
import 'package:http/http.dart' as http;





Future enviarImagenn(String filename) async {

  String url = '${ConfigPaths.pathServicios}/contar'; 
  var request = http.MultipartRequest('POST', Uri.parse(url));

  request.files.add(
    await http.MultipartFile.fromPath(
      'image',
      filename
    )
  );
  //print('envia');
   var res = await request.send();
  //print('envió');
  return res;
}

