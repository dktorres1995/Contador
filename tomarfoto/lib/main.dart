import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/takePicture.dart';


class CameraApp extends StatelessWidget {
  CameraApp(List<CameraDescription> cameras);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraExampleHome(cameras),
    );
  }
}

List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(CameraApp(cameras));
}