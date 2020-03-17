import 'package:flutter/material.dart';
import 'package:tomarfoto/Models/Conteo.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/widgets/widgets/itemHistorial.dart';

class PagHistorial extends StatefulWidget {
  final int pagina;
  PagHistorial(this.pagina);
  @override
  _PagHistorialState createState() => _PagHistorialState();
}

class _PagHistorialState extends State<PagHistorial> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: obtenerListaPaginada(widget.pagina.toString()),
      builder: (ctx, infoPagina) {
        if (infoPagina.hasData) {
          return LayoutBuilder(
            builder: (context,constrains){
              return Container(
                width: constrains.maxWidth,
            child: Column(
              children: (infoPagina.data['lista'] as List<RecursoConteo>)
                  .map((conteoIndividual) {
                return Container(
                    child: ItemHistorial(
                        conteoIndividual.id, conteoIndividual.imagenUrl));
              }).toList(),
            ),
          );
            },
          );
        } else if (infoPagina.hasError) {
          return Center(
            child: Text('${infoPagina.error}'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}