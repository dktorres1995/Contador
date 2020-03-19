import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/instructivo.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';
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
            return ContenidoPagina(
              contenido: MyApp(id: id, listaPuntos: snapshot.data),
              titulo: 'Entrega',
              bloqueo: false,
            );
          } else if (snapshot.hasError) {
            return ContenidoPagina(
                contenido: Text('error en detalle imagen ${snapshot.error}'),
                titulo: 'Entrega',
                bloqueo: false);
          }
          // Por defecto, muestra un loading spinner
          return ContenidoPagina(
              contenido: Center(
                child: CircularProgressIndicator(),
              ),
              titulo: 'Entrega',
              bloqueo: true);
        });
  }
}
