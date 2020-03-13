
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:tomarfoto/Models/Recursos.dart';
Future<List<dynamic>> fetchPost(String id) async {
  final response = await http
      .get('https://object-counter.azurewebsites.net/contar/$id');
  
  final List<dynamic> lista =[];
  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    lista.add(Recursos.fromJson(json.decode(response.body)));
    final resp =   await http
      .get(Recursos.fromJson(json.decode(response.body)).imagenUrl); 
    lista.add(resp);
    return lista;
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
Future<String> ruta() async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Pictures/Dibujo_test';
  await Directory(dirPath).create(recursive: true);

  final String filePath = '$dirPath/${timestamp()}.jpg'; //
  return filePath;
}



Future <List<Recursos>> obtener() async {
  final response = await http
      .get('https://object-counter.azurewebsites.net/obtenerLista');

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    print('si entro');
    final List<dynamic> lista = json.decode(response.body);
    List<Recursos> listaRecursos = [];
    lista.forEach(
        (item) {
          
     try {
         
         listaRecursos.add(Recursos.fromJson(item));
        
       } catch (e) {
      

        
         print("no fue posible obtener la url de la imagen");
                }  
      
      ;});
      
    
     
    return listaRecursos;
    }
    
  else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }

}


Future<http.Response> traerImagen(String url) async {
   final response = await http.get(url);
  if (response.statusCode == 200) {
    return response;
  } else {
    throw ('errorCode: 200');
  }
}

