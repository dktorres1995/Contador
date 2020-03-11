import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tomarfoto/provider/camerasprovider.dart';

class CameraExampleHome extends StatefulWidget {
  final Function showInSnackBar;
  final Function cambioPath;
  CameraExampleHome(this.showInSnackBar,this.cambioPath);

  @override
  _CameraExampleHomeState createState() {
    return _CameraExampleHomeState();
  }
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

  void inicializarCamara(CameraDescription camara) {
    controller = CameraController(
      // Obtén una cámara específica de la lista de cámaras disponibles
      camara,
      // Define la resolución a utilizar
      ResolutionPreset.ultraHigh,
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInfoCamara(),
      builder: (context, listaCamaras) {
        if (listaCamaras.hasData) {
          if (controller == null)
            inicializarCamara(
                (listaCamaras.data as List<CameraDescription>).first);
          return FutureBuilder(
              future: _initializeControllerFuture,
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
        return Center(
            child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).accentColor,
        ));
      },
    );
  }

  Widget retornoHomeCamara(List<CameraDescription> listaCamaras) {
    return LayoutBuilder(builder: (context, constrains) {
      return Stack(children: <Widget>[
        Container(
          height: constrains.maxHeight,
          width: constrains.maxWidth,
          child: Center(
            child: _cameraPreviewWidget(constrains),
          ),
        ),
        Container(
            height: constrains.maxHeight,
            width: constrains.maxWidth,
            padding: EdgeInsets.only(
                top: constrains.maxHeight * 0.8,
                left: constrains.maxWidth * 0.4,
                right: constrains.maxWidth * 0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  child: Container(
                    height: constrains.maxHeight * 0.15,
                    width: constrains.maxWidth * 0.15,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        SafeArea(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                        SafeArea(
                          child: Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).accentColor,
                            size:
                                50 * constrains.maxWidth / constrains.maxHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: controller != null && controller.value.isInitialized
                      ? onTakePictureButtonPressed
                      : null,
                ),
                InkWell(
                  child: Icon(Icons.switch_camera,
                      color: Colors.white,
                      size: 50 * constrains.maxWidth / constrains.maxHeight),
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
  Widget _cameraPreviewWidget(BoxConstraints medidas) {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'no hay camara',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return //CameraPreview(controller);
          AspectRatio(
        aspectRatio: medidas.maxWidth / medidas.maxHeight,
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

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  /*void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }*/

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
        widget.showInSnackBar(
            'error de camara: ${controller.value.errorDescription}');
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
        if (filePath != null) {
          widget.showInSnackBar('Foto Salvada en $filePath');
          widget.cambioPath(filePath);
        }
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      widget.showInSnackBar('Error: selecciona una camara.');
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
    widget.showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
