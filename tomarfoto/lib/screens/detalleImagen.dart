import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/instructivo.dart';
import 'package:tomarfoto/widgets/widgets/TraerInfo.dart';

class DetalleImagen extends StatefulWidget {
  static const routedName = '/detalleImagen';
  @override
  _DetalleImagenState createState() => _DetalleImagenState();
}

class _DetalleImagenState extends State<DetalleImagen> {
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    return FutureBuilder(
        future: fetchPost(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return contenidoPagina(
                MyApp(id: id, listaPuntos: snapshot.data), 'Entrega', context);
          } else if (snapshot.hasError) {
            return contenidoPagina(Text('${snapshot.error}'), 'Entrega', context);
          }

          // Por defecto, muestra un loading spinner
          return contenidoPagina(
                Center(child: CircularProgressIndicator(),), 'Entrega', context);
        });
  }
}
