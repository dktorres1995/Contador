import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/TomaFoto.dart';
import 'package:tomarfoto/widgets/widgets/galeria.dart';
import 'package:tomarfoto/widgets/widgets/visualizarFotoTomada.dart';

class EnvioImagen extends StatefulWidget {
  static const routedName = "/pantallaInicialEnvioImagen";
  @override
  _EnvioImagenState createState() => _EnvioImagenState();
}

class _EnvioImagenState extends State<EnvioImagen> {
  bool tomaFoto = true;
  bool verFoto = false;
  bool verGaleria = false;

  void tomarfoto() {
    setState(() {
      tomaFoto = true;
      verFoto = false;
      verGaleria = false;
    });
  }

  void verfoto() {
    setState(() {
      tomaFoto = false;
      verFoto = true;
      verGaleria = false;
    });
  }

  void vergaleria() {
    setState(() {
      tomaFoto = false;
      verFoto = false;
      verGaleria = true;
    });
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Toma de foto'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: pantallaInicialEnvios(tomaFoto, verFoto, verGaleria,tomarfoto,vergaleria,verfoto),
    );
  }
}

Widget pantallaInicialEnvios(bool tomaFoto, bool verFoto, bool verGaleria, Function tomarfoto, Function vergaleria, Function verfoto) {
  return LayoutBuilder(
    builder: (context, constrains) {
      return Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: constrains.maxHeight * 0.9,
              width: constrains.maxWidth,
              child: Center(
                child: tomaFoto
                    ? CameraExampleHome()
                    : verGaleria
                        ? Galeria()
                        : verFoto ? VisualizacionFotoTomada() : null,
              ),
            ),
          ),
          Container(
              height: constrains.maxHeight * 0.1,
              width: constrains.maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      color: Theme.of(context).accentColor,
                      width: constrains.maxWidth * 0.5,
                      height: constrains.maxHeight * 0.1,
                      padding:
                          EdgeInsets.only(top: constrains.maxHeight * 0.04),
                      child: SafeArea(
                        child: Text(
                          'Galería',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: verGaleria?Colors.white:Colors.blue[800],
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),onTap:  vergaleria,
                  ),
                  InkWell(
                    child: Container(
                      color: Theme.of(context).accentColor,
                      width: constrains.maxWidth * 0.5,
                      height: constrains.maxHeight * 0.1,
                      padding:
                          EdgeInsets.only(top: constrains.maxHeight * 0.04),
                      child: SafeArea(
                        child: Text(
                          'Foto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: tomaFoto?Colors.white:Colors.blue[800],
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    onTap: tomarfoto ,
                  )
                ],
              ))
        ],
      );
    },
  );
}
