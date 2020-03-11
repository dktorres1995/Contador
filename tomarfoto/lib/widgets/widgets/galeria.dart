import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/pathProvider.dart';
import 'package:tomarfoto/widgets/widgets/vistaCarpetasGaleria.dart';

class Galeria extends StatefulWidget {
  Function cambioPathGaleria;
  final Future<String> listaPathGaleriaCel;
  Galeria(this.cambioPathGaleria,this.listaPathGaleriaCel);
  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  File fotoescogida;
  Map<String, List<dynamic>> infoGaleriaCel;

  void setinfoGaleriacel(Map<String, List<dynamic>> mapaRutas) {
    this.infoGaleriaCel = mapaRutas;
  }

  Map<String, List<dynamic>> getinfoGaleriacel() {
    return this.infoGaleriaCel;
  }

  void escogerFoto(File pathFoto) {
    setState(() {
      fotoescogida = pathFoto;
    });
    widget.cambioPathGaleria(pathFoto.path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.listaPathGaleriaCel, //listaPath2(),
      builder: (context, lista) {
        if (lista.hasData) {
          setinfoGaleriacel(listasPaths(lista.data));
          return LayoutBuilder(
            builder: (context, constrains) {
              return Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      height: constrains.maxHeight * 0.45,
                      width: constrains.maxWidth,
                      child: fotoescogida != null
                          ? Card(
                              elevation: 30,
                              child: SafeArea(
                                  child: Image.file(
                                fotoescogida,
                                fit: BoxFit.fill,
                              )))
                          : null),
                  Container(
                    height: constrains.maxHeight * 0.5,
                    width: constrains.maxWidth,
                    margin: EdgeInsets.all(5),
                    child: Card(
                        elevation: 50,
                        child: Carpetas(infoGaleriaCel, escogerFoto)),
                  )
                ],
              );
            },
          );
        }
        if (lista.hasError) {
          if ('${lista.error.runtimeType}' == 'FileSystemException') {
            return Center(
              child: Text('Aun no ha tomado fotos'),
            );
          } else {
            return Text(
                'error(${lista.connectionState})=>${lista.error.runtimeType}');
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}


/**/
