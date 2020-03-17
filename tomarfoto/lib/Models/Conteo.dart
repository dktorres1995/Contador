import 'package:flutter/material.dart';

class RecursoConteo {
  final String id;
  final String imagenUrl;
  final int conteo;
  final String fecha;
  final String nombre;

  RecursoConteo(
      {@required this.id,
      this.imagenUrl,
      this.conteo,
      this.fecha,
      this.nombre});

  factory RecursoConteo.fromJson(Map<String, dynamic> json) {
    return RecursoConteo(
        id: json["_id"],
        imagenUrl: json["image_url"],
        conteo: json['conteo']==null?null:json['conteo'],
        fecha: json['fecha']==null?null:json['fecha'],
        nombre: json['nombre']==null?null:json['nombre']);
  }
}
