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
                      height: constrains.maxHeight * 0.5,
                      width: constrains.maxWidth,
                      color: Colors.white,
                      child: fotoescogida != null
                          ? SafeArea(child: Image.file(fotoescogida))
                          : null),
                  Container(
                    height: constrains.maxHeight * 0.5,
                    width: constrains.maxWidth,
                    child: imprimirGrilla(lista.data, escogerFoto),
                  )
                ],
              );
            },
          ); // imprimirGrilla(lista.data);
        }
        if (lista.hasError) {
          return Text('error(${lista.connectionState})=>${lista.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}

Widget imprimirGrilla(List<dynamic> lista, Function escogerFoto) {
  return GridView(
      padding: const EdgeInsets.all(10),
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
