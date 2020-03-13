import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/pathProvider.dart';
import 'package:tomarfoto/widgets/widgets/vistaCarpetasGaleria.dart';

class Galeria extends StatefulWidget {
 final Function cambioPathGaleria;
 Galeria(this.cambioPathGaleria);
  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  File fotoescogida;
  Map<String, List<dynamic>> infoGaleriaCel;

 

  void escogerFoto(File pathFoto) {
    setState(() {
      fotoescogida = pathFoto;
    });
    widget.cambioPathGaleria(pathFoto.path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listaPath(), //listaPath2(),
      builder: (context, lista) {
        if (lista.hasData) {
         infoGaleriaCel=listasPaths(lista.data);
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
                                height: constrains.maxHeight,
                                width: constrains.maxWidth,
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
