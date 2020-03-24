import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/detalleImagen.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ItemHistorial extends StatefulWidget {
  ItemHistorial(
      {@required this.idImag,
      this.urlImag,
      this.urlImagSmall,
      this.conteo,
      this.fecha,
      this.nombre});

  final String idImag;
  final String urlImag;
  final String urlImagSmall;
  final int conteo;
  final String fecha;
  final String nombre;
  @override
  _itemHistorial createState() => _itemHistorial();
}

class _itemHistorial extends State<ItemHistorial> {
  TextEditingController nombreConteo = new TextEditingController();

  void actualizar() {
    actualizarNombre(widget.idImag, nombreConteo.text.toString())
        .then((res) {});
  }

  void eliminar() {
    deshabilitarConteo(widget.idImag).then((res) {});
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
          child: Card(
            elevation: 20,
            child: Column(
              children: <Widget>[
                InkWell(
                    child: Container(
                      height: medida.maxHeight*0.7,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: medida.maxWidth * 0.3,
                            color: Colors.grey,
                            child:widget.urlImagSmall==null? Center(child: Icon(Icons.error),): Image.network(
                             widget.urlImagSmall,
                            ),
                          ),
                          Container(
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
                                      fontSize: medida.maxHeight * 0.1),
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
                                ),
                        ],
                      ),
                    ),
                    onTap: () {
                      if (widget.conteo != null) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            DetalleImagen.routedName, (ro) => false,
                            arguments: widget.idImag);
                      }
                    }
                    
                    ),
               
              ],
            ),
          ),
        );
      },
    );
  }
}
/*,
          
            }*/
