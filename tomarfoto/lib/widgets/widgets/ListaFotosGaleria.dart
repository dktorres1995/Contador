import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/itemFoto.dart';

class GrillaFotos extends StatelessWidget {
 final List<dynamic> lista;
  final Function escogerFoto;
  GrillaFotos({@required this.lista, @required this.escogerFoto});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(0),
      children: lista
          .map((itemImagen2) => ItemFoto(
                path: File(itemImagen2 as String),
                escoger: escogerFoto,
              ))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 4,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0));
  }
}