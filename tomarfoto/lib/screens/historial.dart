import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/instructivo.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/widgets/widgets/paginaHistorial.dart';

class Historial extends StatefulWidget {
  static const routedName = '/historial';

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  void reiniciar() {
    setState(() {});
  }

  Widget contenidoHistorial(int totalPag, BuildContext ctx) {
    return ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: totalPag,
        itemBuilder: (ctx, index) {
          return Container(
              height: 1000,
              width: double.infinity,
              child: PagHistorial(index + 1));
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: obtenerListaPaginadatotal(),
      builder: (context, infoIni) {
        if (infoIni.hasData) {
          return contenidoPagina(
              contenidoHistorial(infoIni.data['totalPag'] as int, context),
              'Historial',
              context);
        } else if (infoIni.hasError) {
          return contenidoPagina(
              Text('${infoIni.error}'), 'Historial', context);
        }

        return contenidoPagina(
            Center(child: CircularProgressIndicator()), 'Historial', context);
      },
    );
  }
}
