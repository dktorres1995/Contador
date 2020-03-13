import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tomarfoto/Models/Recursos.dart';

Future<Recursos> fetchPost(String id) async {
  final response =
      await http.get('https://object-counter.azurewebsites.net/contar/$id');

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    return Recursos.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

Future<List<Recursos>> obtener() async {
  final response =
      await http.get('https://object-counter.azurewebsites.net/obtenerLista');

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    print('si entro');
    final List<dynamic> lista = json.decode(response.body);
    List<Recursos> listaRecursos = [];
    lista.forEach((item) {
      try {
        listaRecursos.add(Recursos.fromJson(item));
      } catch (e) {
        print("no fue posible obtener la url de la imagen");
      }
    });

    return listaRecursos;
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}
