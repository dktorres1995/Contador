import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/cameraHome.dart';
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
