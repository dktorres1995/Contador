import 'dart:convert';
import 'dart:io';
import 'package:storage_path/storage_path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> listaPath() async {
  return await StoragePath.imagesPath;
}

Future<List<FileSystemEntity>> listaPath2() async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Pictures/Conteo';
  var ret = Directory(dirPath).list();
  return ret.toList();
}


Map<String, List<dynamic>> listasPaths(String listaPath) {
  Map<String, List<dynamic>> direcciones = Map<String, List<dynamic>>();

  List<dynamic> listaCarpetas = json.decode(listaPath);
  for (var carpeta in listaCarpetas) {
    //print(carpeta);
    List<dynamic> lista = carpeta['files'];
    String ruta = lista.first;
    List<String> frag = ruta.split('/');
    direcciones[frag.elementAt(frag.length - 2)] = lista;
  }
  /*final myDir = new Directory('/storage/emulated/0/Pictures/test');
  myDir.exists().then((isThere) {
    isThere ? print('exists') : myDir.create(recursive: true);//print('no existe');//
  });*/

  return direcciones;
}
