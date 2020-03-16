import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/provider/providerConfig.dart';
import 'package:tomarfoto/widgets/widgets/TomaFoto.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as LibIma;
List<CameraDescription> cameras = [];



Future<List<CameraDescription>> getInfoCamara() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
   return cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
    return null;
  }
}

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

Future enviarThumIma(String filename) async {
  
  String url = '${ConfigPaths.pathServicios}/contar---------'; 
  var request = http.MultipartRequest('POST', Uri.parse(url));
  var rutaEnvio = '';
   var imathumb = LibIma.decodeJpg(File(filename).readAsBytesSync());
  imathumb = LibIma.copyResize(imathumb,height: 200,width: 200,interpolation: LibIma.Interpolation.nearest);
  ruta().then((ruta){
    rutaEnvio = ruta;
    File(ruta).writeAsBytesSync(LibIma.encodeJpg(imathumb));
     
  });

request.files.add(
    await http.MultipartFile.fromPath(
      'image',
      rutaEnvio 
    )
  );
  //print('envia');
   var res = await request.send();
  //print('envió');
  return res;
}