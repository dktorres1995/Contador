import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/TomaFoto.dart';
import 'package:http/http.dart' as http;
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

void enviarImagenn(String filename) async {

  String url = 'https://object-counter.azurewebsites.net/contar'; 
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(
    await http.MultipartFile.fromPath(
      'image',
      filename
    )
  );
  //print('envia');
   await request.send();
  //print('envió');
}