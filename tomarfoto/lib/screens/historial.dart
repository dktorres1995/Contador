import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../provider/historialprovider.dart';
import '../screens/detalleImagen.dart';
import '../widgets/widgets/Plantilla.dart';
import '../widgets/widgets/paginaHistorial.dart';

class Historial extends StatefulWidget {
  static const routedName = '/historial';

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  TextEditingController busqueda;
  void reiniciar() {
    print('reinicio');
    setState(() {});
  }

  Widget contenidoHistorial(int totalPag, BuildContext ctx) {
    bool cuadroBusqueda = false;
    return LayoutBuilder(
      builder: (ctx, medida) {
        return Column(
          children: <Widget>[
            cuadroBusqueda?Container(
                height: medida.maxHeight * 0.07,
                width: medida.maxWidth,color: Colors.transparent,
                padding:
                    EdgeInsets.symmetric(horizontal: medida.maxWidth * 0.1),
                child: Card(
                  elevation: 20,
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.search),
                      TextField(
                        enabled: false,
                        controller: busqueda,
                        decoration: InputDecoration(
                            hintText: "",
                            fillColor: Color(0X1F000000),
                            filled: true),
                      ),
                    ],
                  ),
                )):Container(),
            Container(
              height: cuadroBusqueda?medida.maxHeight * 0.93:medida.maxHeight,
              width: medida.maxWidth,
              child: ListView.builder(
                  dragStartBehavior: DragStartBehavior.start,
                  addAutomaticKeepAlives: true,
                  itemCount: totalPag,
                  itemBuilder: (ctx, index) {
                    return Container(
                      height: 1500,
                      width: double.infinity,
                      child: PagHistorial(index + 1),
                    );
                  }),
            ),
          ],
        );
      },
    );
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
              bloqueo: false,
              confirmacionSalida: false,
              mensajeConfirmacionSalida: () {});
        } else if (infoIni.hasError) {
          mensaje(context, 'Error al cargar historial',
              'Se ha presentado un error al cargar el historial');
          return ContenidoPagina(
              contenido: Text('${infoIni.error}'),
              titulo: 'Historial',
              bloqueo: false,
              confirmacionSalida: false,
              mensajeConfirmacionSalida: () {});
        }

        return ContenidoPagina(
            contenido: Center(child: CircularProgressIndicator()),
            titulo: 'Historial',
            bloqueo: false,
            confirmacionSalida: false,
            mensajeConfirmacionSalida: () {});
      },
    );
  }
}
