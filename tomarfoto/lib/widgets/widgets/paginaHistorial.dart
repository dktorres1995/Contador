import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Numerate/Models/Conteo.dart';
import 'package:Numerate/provider/historialprovider.dart';
import 'package:Numerate/screens/detalleImagen.dart';
import 'package:Numerate/widgets/widgets/itemHistorial.dart';

class PagHistorial extends StatefulWidget {
  final int pagina;
  PagHistorial(this.pagina);
  @override
  _PagHistorialState createState() => _PagHistorialState();
}

class _PagHistorialState extends State<PagHistorial> {
  bool hoy = true;
  bool ayer = true;
  bool estaSemana = true;
  bool otrosDias = true;
  DateFormat dateConvert = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  DateTime now = DateTime.now();

  Widget showDate(String fechaItem) {
    DateTime dateItem = dateConvert.parse(fechaItem);
    Widget salida = Text(
      now.day == dateItem.day && hoy
          ? 'HOY'
          : now.subtract(Duration(days: 1)).day == dateItem.day && ayer
              ? 'AYER'
              : !( now.day == dateItem.day) && !(now.subtract(Duration(days: 1)).day == dateItem.day)&& 
        now.subtract(Duration(days: 7)).isBefore(dateItem) && estaSemana
                  ? 'ESTA SEMANA '
                  : now.subtract(Duration(days: 7)).isAfter(dateItem) && otrosDias
                      ? 'DIAS ANTERIORES'
                      : '',
      style: TextStyle(color: Colors.grey,fontSize: 20),
    );

    if ( now.day == dateItem.day) {
      hoy = false;
    } else if (
        now.subtract(Duration(days: 1)).day == dateItem.day) {
      ayer = false;
    } else if ( !( now.day == dateItem.day) && !(now.subtract(Duration(days: 1)).day == dateItem.day)&& 
        now.subtract(Duration(days: 7)).isBefore(dateItem)) {
      estaSemana = false;
    } else if (now.subtract(Duration(days: 7)).isAfter(dateItem)) {
      otrosDias = false;
    }

    return salida;
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
                  ?Text('No hay registros en esta cuenta')
                  : Column(
                      children:
                          (infoPagina.data['lista'] as List<RecursoConteo>)
                              .map((conteoIndividual) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: medida.maxHeight*0.01),
                                height: medida.maxHeight / 10,
                                child: conteoIndividual.id != null 
                                    ? ItemHistorial(
                                        idImag: conteoIndividual.id,
                                        conteo: conteoIndividual.conteo,
                                        fecha: conteoIndividual.fecha,
                                        nombre: conteoIndividual.nombre,
                                        urlImag: conteoIndividual.imagenUrl,
                                        urlImagSmall:
                                            conteoIndividual.imagenUrlSmall
                                      )
                                  
                                    : Divider()),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,bottom: 20),
                              child: showDate(conteoIndividual.fecha),
                            ),
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
