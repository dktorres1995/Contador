import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/detalleImagen.dart';
import 'package:tomarfoto/screens/historial.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ItemHistorial extends StatefulWidget {
  ItemHistorial(
      {@required this.idImag,
      this.urlImag,
      this.conteo,
      this.fecha,
      this.nombre});

  final String idImag;
  final String urlImag;
  final int conteo;
  final String fecha;
  final String nombre;
  @override
  _itemHistorial createState() => _itemHistorial();
}

class _itemHistorial extends State<ItemHistorial> {
  TextEditingController nombreConteo = new TextEditingController();
  

  void actualizar() {
    actualizarNombre(widget.idImag, nombreConteo.text.toString()).then((res) {
      print('enviado nombre');
    });
  }

  void eliminar() {
    deshabilitarConteo(widget.idImag).then((res) {
      print('elemento eliminado');
    });
  }

  void refrescar(String conteo) {
    setState(() {});
  }

  String convFecha(String fecha) {
    initializeDateFormatting();
    //DateTime now = DateTime.now();
   //var dateString = DateFormat('dd-MM-yyyy').format(now);
  //final String configFileName = 'lastConfig.$dateString.json';
    try {
      DateFormat dateConvert = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      //DateFormat dateFormat = DateFormat(" MMMM dd yyyy", 'es_ES');
      DateTime date = dateConvert.parse(fecha);
      return DateFormat.yMd().format(date);
    } on FormatException {
      return fecha;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, medida) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: medida.maxWidth * 0.05,
              vertical: medida.maxHeight * 0.05),
          child: InkWell(
            child: Card(
              elevation: 20,
              child: Row(
                children: <Widget>[
                  Container(
                    height: medida.maxHeight,
                    width: medida.maxWidth * 0.3,
                    padding: EdgeInsets.all(medida.maxHeight * 0.1),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.network(
                      widget.urlImag,
                      cacheWidth: (medida.maxWidth * 0.3).floor(),
                      cacheHeight: (medida.maxHeight).floor(),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                  Container(
                    height: medida.maxHeight,
                    width: medida.maxWidth * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.nombre == null
                              ? 'No tiene Nombre'
                              : widget.nombre,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: medida.maxHeight * 0.15),
                        ),
                        Text(
                          widget.fecha == null
                              ? 'no hay fecha'
                              : convFecha(widget.fecha),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: medida.maxHeight * 0.1,
                              fontStyle: FontStyle.italic),
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            showBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                    height: 200.0,
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                            title: Text(
                                              'Eliminar del historial',
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Eliminar "),
                                                      content: Text(
                                                          '¿Esta seguro que desea eliminar ? \n ${widget.nombre}'),
                                                      actions: <Widget>[
                                                        new FlatButton(
                                                          child: new Text(
                                                              'Cancelar'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        new FlatButton(
                                                          child: new Text(
                                                              'Aceptar'),
                                                          onPressed: () {
                                                            eliminar();
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(Historial
                                                                    .routedName);
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  });
                                            }),
                                        ListTile(
                                          title: Text(
                                            'Cambiar Nombre',
                                            textAlign: TextAlign.center,
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text("Cambiar Nombre"),
                                                    content: TextField(
                                                      controller: nombreConteo,
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "Nombre"),
                                                    ),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        child: new Text(
                                                            'Cancelar'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      new FlatButton(
                                                        child:
                                                            new Text('Aceptar'),
                                                        onPressed: () {
                                                          actualizar();
                                                          Navigator.of(context)
                                                              .pushNamed(Historial
                                                                  .routedName);
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                        ListTile(
                                            title: Text(
                                              'Cerrar',
                                              textAlign: TextAlign.center,
                                            ),
                                            onTap: () =>
                                                Navigator.of(context).pop()),
                                      ],
                                    ));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  widget.conteo == null
                      ? Center(
                          child: Icon(Icons.access_time),
                        )
                      : Text(
                          '${widget.conteo}',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold),
                        )
                ],
              ),
            ),
            onTap: () {
              if (widget.conteo != null) {
                Navigator.of(context).pushNamed(DetalleImagen.routedName,
                    arguments: widget.idImag);
              }
            },
          ),
        );
      },
    );
  }
}
