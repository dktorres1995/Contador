import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/TomaFoto.dart';
import 'package:tomarfoto/widgets/widgets/galeria.dart';
import 'package:tomarfoto/widgets/widgets/visualizarFotoTomada.dart';
import 'package:tomarfoto/provider/camerasprovider.dart';

class EnvioImagen extends StatefulWidget {
  static const routedName = "/pantallaInicialEnvioImagen";
  @override
  _EnvioImagenState createState() => _EnvioImagenState();
}

class _EnvioImagenState extends State<EnvioImagen> {
  bool tomaFoto = true;
  bool verFoto = false;
  bool verGaleria = false;
  bool tomaGaleria = false;
  String pathFoto = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  void cambioPath(String path) {
    print(path);
    setState(() {
      pathFoto = path;
    });
    verfoto();
  }

   void cambioPathGaleria(String path) {
     print(path);
    setState(() {
      pathFoto = path;
      tomaGaleria = true;
    });
  }

  void mostrarMensaje(String mensaje) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void enviarFotoBase() {
    enviarImagenn(pathFoto);
    mostrarMensaje('Foto enviada con exito');
    //Navigator.of(context).pop();
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
                    color: verFoto || tomaGaleria ? Colors.blue : Colors.grey, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              onTap: verFoto || tomaGaleria ? enviarFotoBase : null,
            ),
          )
        ],
      ),
      body: pantallaInicialEnvios(tomaFoto, verFoto, verGaleria, tomarfoto,
          vergaleria, verfoto, mostrarMensaje, cambioPath, cambioPathGaleria ,pathFoto),
    );
  }
}

Widget pantallaInicialEnvios(
    bool tomaFoto,
    bool verFoto,
    bool verGaleria,
    Function tomarfoto,
    Function vergaleria,
    Function verfoto,
    Function mostrarMensaje,
    Function cambioPath,
    Function cambioPathGaleria,
    String pathFoto) {
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
                    ? CameraExampleHome(mostrarMensaje, cambioPath)
                    : verGaleria
                        ? Galeria(cambioPathGaleria)
                        : verFoto ? VisualizacionFotoTomada(pathFoto) : null,
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
                              color:
                                  verGaleria ? Colors.white : Colors.blue[800],
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    onTap: vergaleria,
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
                              color: tomaFoto ? Colors.white : Colors.blue[800],
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    onTap: tomarfoto,
                  )
                ],
              ))
        ],
      );
    },
  );
}
