import 'package:flutter/material.dart';
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
    return contenidoPagina(MyApp(id),'Entrega',context);
  }
}
