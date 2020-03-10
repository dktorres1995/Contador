import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tomarfoto/widgets/widgets/itemFoto.dart';

class Galeria extends StatefulWidget {
  Function cambioPathGaleria;
  Galeria(this.cambioPathGaleria);
  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  File fotoescogida;

  void escogerFoto(File pathFoto) {
    setState(() {
      fotoescogida = pathFoto;
    });
    widget.cambioPathGaleria(pathFoto.path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listaPath2(),
      builder: (context, lista) {
        if (lista.hasData) {
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
                    height: constrains.maxHeight * 0.05,
                    width: constrains.maxWidth,
                    child: Text(
                      'fotos',
                      style: TextStyle(color: Theme.of(context).accentColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: constrains.maxHeight * 0.45,
                    width: constrains.maxWidth,
                    margin: EdgeInsets.all(5),
                    child: Card(
                      elevation: 50,
                      child: imprimirGrilla(lista.data, escogerFoto),
                    ),
                  )
                ],
              );
            },
          ); // imprimirGrilla(lista.data);
        }
        if (lista.hasError) {
          if ('${lista.error.runtimeType}'=='FileSystemException') {
            return Center(child: Text('Aun no ha tomado fotos'),);
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

Widget imprimirGrilla(List<dynamic> lista, Function escogerFoto) {
  return GridView(
      padding: const EdgeInsets.all(0),
      children: lista
          .map((itemImagen2) => ItemFoto(
                path: itemImagen2,
                escoger: escogerFoto,
              ))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 4,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0));
}

Future<List<FileSystemEntity>> listaPath2() async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Pictures/flutter_test';
  var ret = Directory(dirPath).list();
  return ret.toList();
}
