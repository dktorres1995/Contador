import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';
import 'package:tomarfoto/widgets/widgets/paginaHistorial.dart';

class Historial extends StatefulWidget {
  static const routedName = '/historial';

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  void reiniciar() {
    print('reinicio');
    setState(() {});
  }

  Widget contenidoHistorial(int totalPag, BuildContext ctx) {
    return ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: totalPag,
        itemBuilder: (ctx, index) {
          return Container(
            height: 1500,
            width: double.infinity,
            child: PagHistorial(index + 1),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: obtenerListaPaginadatotal(),
      builder: (context, infoIni) {
        if (infoIni.hasData) {
          return ContenidoPagina(
              contenido:
                  contenidoHistorial(infoIni.data['totalPag'] as int, context),
              titulo: 'Historial',
              bloqueo: false,confirmacionSalida: false,mensajeConfirmacionSalida: (){});
        } else if (infoIni.hasError) {
          return ContenidoPagina(
              contenido: Text('${infoIni.error}'),
              titulo: 'Historial',
              bloqueo: false,confirmacionSalida: false,mensajeConfirmacionSalida: (){});
        }

        return ContenidoPagina(
            contenido: Center(child: CircularProgressIndicator()),
            titulo: 'Historial',
            bloqueo: false,confirmacionSalida: false,mensajeConfirmacionSalida: (){});
      },
    );
  }
}
