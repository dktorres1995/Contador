import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/itemFoto.dart';

class GrillaFotos extends StatelessWidget {
  final List<dynamic> lista;
  final Function escogerFoto;
  GrillaFotos({@required this.lista, @required this.escogerFoto});

  @override
  Widget build(BuildContext context) {
    ImageCache().clear();
    return LayoutBuilder(
      builder: (context, constrains) {
        return GridView.builder(
            itemCount: lista.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0),
            itemBuilder: (context, index) {
              return ItemFoto(path:File(lista.elementAt(index) as String),escoger: escogerFoto,);
            });
      },
    );
  }
}
/*InkWell(
                child: Container(
                  width: constrains.maxWidth*0.5,
                  height: constrains.maxHeight*0.25,
                  child: Image.file(File(lista.elementAt(index) as String),
                      filterQuality: FilterQuality.none,fit: BoxFit.fill,),
                ),
                onTap: () {
                  escogerFoto(File(lista.elementAt(index) as String));
                },
              ); */