import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/itemFoto.dart';

class GrillaFotos extends StatelessWidget {
  final List<dynamic> lista;
  final Function escogerFoto;
  GrillaFotos({@required this.lista, @required this.escogerFoto});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(lista.length>=50?50:lista.length,(index) {
        return InkWell(
          child: Container(
            child: Image.file(
              File(lista.elementAt(index) as String),
              filterQuality: FilterQuality.none
            ),
          ),
          onTap: () {
            escogerFoto(File(lista.elementAt(index) as String));
          },
        );
      }),
    );
  }
}
