import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/detalleImagen.dart';

class ItemHistorial extends StatelessWidget {
  final String idImag;
  final String urlImag;
  final int conteo;
  final String fecha;
  final String nombre;

  ItemHistorial(
      {@required this.idImag,
      this.urlImag,
      this.conteo,
      this.fecha,
      this.nombre});
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
                      urlImag,
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
                          nombre == null ? 'No tiene Nombre' : nombre,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: medida.maxHeight * 0.15),
                        ),
                        Text(
                          fecha == null ? 'no hay fecha' : fecha,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: medida.maxHeight * 0.1,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                  conteo == null
                      ? Center(
                        child: Icon(Icons.access_time),
                      )
                      : Text(
                          '$conteo',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold),
                        )
                ],
              ),
            ),onTap:(){
              if (conteo!=null){
                 Navigator.of(context)
                                .pushNamed(DetalleImagen.routedName,arguments: idImag);
              }
            } ,
          ),
        );
      },
    );
  }
}


