import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tomarfoto/Models/Conteo.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/detalleImagen.dart';
import 'package:tomarfoto/widgets/widgets/itemHistorial.dart';

class PagHistorial extends StatefulWidget {
  final int pagina;
  PagHistorial(this.pagina);
  @override
  _PagHistorialState createState() => _PagHistorialState();
}

class _PagHistorialState extends State<PagHistorial> {
  bool hoy = false;
  bool ayer = false;
  bool estaSemana = false;
  DateFormat dateConvert = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  DateTime now = DateTime.now();

  Widget showDate(String fechaItem) {
    DateTime dateItem = dateConvert.parse(fechaItem);
    hoy = !hoy ? now.day == dateItem.day ? true : false : hoy;
    ayer = !ayer
        ? now.subtract(Duration(days: 1)).day == dateItem.day ? true : ayer
        : false;
    estaSemana = !estaSemana
        ? now.subtract(Duration(days: 7)).isBefore(dateItem) ? true : false
        : estaSemana;

    return Text(now.day == dateItem.day
        ? 'hoy'
        : now.subtract(Duration(days: 1)).day == dateItem.day 
            ? 'ayer'
            : now.subtract(Duration(days: 7)).isBefore(dateItem)
                ? 'esta Semana'
                : 'dias anteriores');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: obtenerListaPaginada(widget.pagina.toString()),
      builder: (ctx, infoPagina) {
        if (infoPagina.hasData) {
          return LayoutBuilder(
            builder: (context, medida) {
              return (infoPagina.data['lista'] as List<RecursoConteo>).isEmpty
                  ? Center(
                      child: Text('No hay registros en esta cuenta'),
                    )
                  : Column(
                      children:
                          (infoPagina.data['lista'] as List<RecursoConteo>)
                              .map((conteoIndividual) {
                        return Stack(
                          children: <Widget>[
                            showDate(conteoIndividual.fecha),
                            Container(
                                height: medida.maxHeight / 10,
                                child: conteoIndividual.id != null
                                    ? ItemHistorial(
                                        idImag: conteoIndividual.id,
                                        conteo: conteoIndividual.conteo,
                                        fecha: conteoIndividual.fecha,
                                        nombre: conteoIndividual.nombre,
                                        urlImag: conteoIndividual.imagenUrl,
                                        urlImagSmall:
                                            conteoIndividual.imagenUrlSmall,
                                      )
                                    : Divider()),
                          ],
                        );
                      }).toList(),
                    );
            },
          );
        } else if (infoPagina.hasError) {
          mensaje(context, 'Error al cargar historial',
              'Se ha presentado un error al cargar algunos elementos del historial.');
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
