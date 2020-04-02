import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/camerasprovider.dart';
import 'package:tomarfoto/screens/Espera.dart';
import 'package:tomarfoto/screens/historial.dart';

class EnvioImagen2 extends StatefulWidget {
  static const routedName = "/pantallaInicialEnvioImagen2";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EnvioImagen2> {
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageGal() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void mostrarMensaje(String mensaje) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void enviarFotoBase(BuildContext ctx) {
    //mostrarMensaje('Espere mientras se carga la foto');
    print('oprimió');
    Navigator.of(context)
          .pushNamed(EsperaScreen.routedName);
    enviarImagenn(_image.path).then((res) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Historial.routedName, (ro) => false);
      showDialog(
          context: ctx,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
                title: Text('Envio correcto',
                    style: TextStyle(color: Colors.blue)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                titleTextStyle: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
                content: Text(
                    'Se ha enviado la foto, por favor espere hasta que el sistema haga el conteo'));
          });
    }).catchError((err){
      
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Historial.routedName, (ro) => false);
      print('error: $err');
        showDialog(
          context: ctx,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
                title: Text('Envio Incorrecto',
                    style: TextStyle(color: Colors.blue)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                titleTextStyle: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
                content: Text(
                    'Ha habido un error al enviar la foto'));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Toma de foto'),
          backgroundColor: Theme.of(context).accentColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: InkWell(
                child: Text(
                  'siguiente',
                  style: TextStyle(
                      color: _image != null ? Colors.blue : Colors.grey,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  if (_image != null) enviarFotoBase(context);
                },
              ),
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constrains) {
            return Column(
              children: <Widget>[
                Container(
                  width: constrains.maxWidth,
                  height: constrains.maxHeight * 0.9,
                  child: Center(
                      child: _image == null
                          ? Text('Escoger una imagen')
                          : Image.file(_image)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                          padding:
                              EdgeInsets.only(top: constrains.maxHeight * 0.04),
                          width: constrains.maxWidth * 0.5,
                          height: constrains.maxHeight * 0.1,
                          color: Colors.white,
                          child: Text(
                            'galería',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )),
                      onTap: getImageGal,
                    ),
                    InkWell(
                      child: Container(
                        padding:
                            EdgeInsets.only(top: constrains.maxHeight * 0.04),
                        color: Colors.white,
                        width: constrains.maxWidth * 0.5,
                        height: constrains.maxHeight * 0.1,
                        child: Text('Foto',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                      ),
                      onTap: getImage,
                    )
                  ],
                )
              ],
            );
          },
        ));
  }
}
