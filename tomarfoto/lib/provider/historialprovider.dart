
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tomarfoto/Models/Recursos.dart';
Future<Recursos> fetchPost() async {
  final response = await http
      .get('https://object-counter.azurewebsites.net/contar/5e5eaed5123e0b40304c9850');

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    return Recursos.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

