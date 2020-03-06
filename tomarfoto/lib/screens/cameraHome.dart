import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tomarfoto/provider/camerasprovider.dart';

class CameraExampleHome extends StatefulWidget {
  static const routedName = '/CameraHome';
  @override
  _CameraExampleHomeState createState() {
    return _CameraExampleHomeState();
  }
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _CameraExampleHomeState extends State<CameraExampleHome>
    with WidgetsBindingObserver {
  CameraController controller;
  String imagePath;
  bool controladorBool = true; //true posterior, false selfie
  Future<void> _initializeControllerFuture;

  void cambiarCamara(List<CameraDescription> listaCamaras) {
    onNewCameraSelected(controladorBool
        ? listaCamaras.elementAt(0)
        : listaCamaras.elementAt(1));
    setState(() {
      controladorBool = controladorBool ? false : true;
      print(controladorBool);
    });
  }

  Future<void> inicializarCamara(CameraDescription camara){
        controller = CameraController(
      // Obtén una cámara específica de la lista de cámaras disponibles
      camara,
      // Define la resolución a utilizar
      ResolutionPreset.medium,
    );
    // A continuación, debes inicializar el controlador. Esto devuelve un Future!
    _initializeControllerFuture = controller.initialize();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
/*
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }*/

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Toma de foto'),
      ),
      body: FutureBuilder(
        future: getInfoCamara(),
        builder: (context, listaCamaras) {
          if (listaCamaras.hasData) {
            if(controller==null)inicializarCamara((listaCamaras.data as List<CameraDescription>).first);
            return FutureBuilder(
                future: _initializeControllerFuture  ,
                builder: (context, snapshot) {
                  print(listaCamaras.data);
                  if (snapshot.connectionState == ConnectionState.done) {
                    return retornoHomeCamara(listaCamaras.data);
                  }
                  return CircularProgressIndicator();
                });
          }
          if (listaCamaras.hasError) {
            return Center(
              child: Text(listaCamaras.error),
            );
          }
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.red,));
        },
      ),
    );
  }

  Widget retornoHomeCamara(List<CameraDescription> listaCamaras) {
    return LayoutBuilder(builder: (context, constrains) {
      return Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
            ),
            Text('espacio botones'),
          ],
        ),
        Container(
            height: constrains.maxHeight,
            width: constrains.maxWidth,
            padding: EdgeInsets.only(top: constrains.maxHeight * 0.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: controller != null && controller.value.isInitialized
                      ? onTakePictureButtonPressed
                      : null,
                ),
                InkWell(
                  child: Icon(
                    Icons.switch_camera,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    if (controller != null && controller.value.isInitialized) {
                      cambiarCamara(listaCamaras);
                    }
                  },
                ),
              ],
            ))
      ]);
    });
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  /// Display the thumbnail of the captured image or video.
  /*Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           imagePath == null
                ? Container()
                : SizedBox(
                    child:  Image.file(File(imagePath))
                       
          ],
        ),
      ),
    );
  }
*/
  /// Display the control bar with buttons to take pictures and record videos.
  /*Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }*/

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget(cameras) {
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No se encontraron camaras');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null && controller.value.isRecordingVideo
                  ? null
                  : onNewCameraSelected,
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) showInSnackBar('Picture saved to $filePath');
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
