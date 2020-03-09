import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Galeria extends StatefulWidget {
  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listaPath2(),
      builder: (context, lista) {
        List<dynamic> listaPaths = lista.data;
        print(listaPaths.first);
        return ListView.builder(
            itemCount: listaPaths.length, 
            itemBuilder: (context, index) {
              return Image.file(listaPaths.elementAt(index));
            });
      },
    );
  }
}

Widget imprimirPath(String pathlist) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[Text(pathlist)],
    ),
  );
}

Future<List<FileSystemEntity>> listaPath2() async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Pictures/flutter_test';
  var ret = await Directory(dirPath).list();
  return ret.toList();
}
