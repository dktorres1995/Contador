import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/camerasprovider.dart';

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

  void enviarFotoBase() {
    mostrarMensaje('Enviando imagen ...');
    enviarImagenn(_image.path).then((res) {
      Navigator.of(context).pop();
      mostrarMensaje('Foto enviada con exito');
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
                onTap: _image != null ? enviarFotoBase : null,
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
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'galería',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )),
                      onTap: getImageGal,
                    ),
                    InkWell(
                      child: Container(
                        padding:
                            EdgeInsets.only(top: constrains.maxHeight * 0.04),
                        color: Theme.of(context).accentColor,
                        width: constrains.maxWidth * 0.5,
                        height: constrains.maxHeight * 0.1,
                        child: Text('Foto',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
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