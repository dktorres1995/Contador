import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/Espera.dart';
import 'package:tomarfoto/screens/historial.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';
import 'package:tomarfoto/widgets/widgets/TraerInfo.dart';

class DetalleImagen extends StatefulWidget {
  static const routedName = '/detalleImagen';
  @override
  _DetalleImagenState createState() => _DetalleImagenState();
}

class _DetalleImagenState extends State<DetalleImagen> {
  List<Map<String, int>> etAgregadas = List<Map<String, int>>();
  List<Map<String, int>> etEliminadas = List<Map<String, int>>();
  List<Map<String, int>> centros = List<Map<String, int>>();

  void addEtiquetas(List<Map<String, int>> listaentrante) {
    etAgregadas = listaentrante;
  }

  void eliminadasEtiquetas(List<Map<String, int>> listaentrante) {
    etEliminadas = listaentrante;
  }

  void actualizarCentros(List<Map<String, int>> listaentrante) {
    centros = listaentrante;
  }

  void enviarTodo(String id, BuildContext ctx) {
    Navigator.of(context).pushNamed(EsperaScreen.routedName);
    actualizarListas(etAgregadas, etEliminadas, centros, id).then((res) {
      print('esta es la respuesta ${res.body}');
      Navigator.of(context).pushNamed(Historial.routedName);
      mensaje(ctx, 'Cambios realizados',
          'sus cambios se han guardado exitosamente');
    }).catchError((onError) {
      Navigator.of(context).pushNamed(Historial.routedName);
      mensaje(ctx, 'Error', 'Hubo un error al Actualizar los cambios, por favor registrelos nuevamente');
    });
  }

  void mensajeConfirmacionEnvio(String id, BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(left: 50),
            title: Text(
              "¿Descartar cambios? ",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  child: Text('Guardar Cambios',
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  onTap: () {
                    Navigator.of(context).pop();
                    enviarTodo(id, ctx);
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
                InkWell(
                  child: Text('Descartar Cambios',
                      style: TextStyle(color: Colors.red)),
                  onTap: () =>
                      Navigator.of(context).pushNamed(Historial.routedName),
                ),
                Divider(
                  color: Colors.black,
                ),
                InkWell(
                  child: Text(
                    'Continuar editando',
                  ),
                  onTap: () => Navigator.of(context).pop(),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;

    return FutureBuilder(
        future: fetchPost(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ContenidoPagina(
                contenido: MyApp(
                  id: id,
                  listaPuntos: snapshot.data,
                  anadirEtiquetas: this.addEtiquetas,
                  eliminarEtiquetas: this.eliminadasEtiquetas,
                  actualizarCentros: this.actualizarCentros,
                ),
                titulo: 'Entrega',
                bloqueo: false,
                confirmacionSalida: true,
                mensajeConfirmacionSalida: () {
                  mensajeConfirmacionEnvio(id, context);
                });
          } else if (snapshot.hasError) {
            return ContenidoPagina(
                contenido: Text('error en detalle imagen ${snapshot.error}'),
                titulo: 'Entrega',
                bloqueo: false,
                confirmacionSalida: false,
                mensajeConfirmacionSalida: () {});
          }
          // Por defecto, muestra un loading spinner
          return ContenidoPagina(
              contenido: Center(
                child: CircularProgressIndicator(),
              ),
              titulo: 'Entrega',
              bloqueo: true,
              confirmacionSalida: false,
              mensajeConfirmacionSalida: () {});
        });
  }
}

void mensaje(BuildContext ctx, String titulo, String mensaje) {
  showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
            title: Text(titulo, style: TextStyle(color: Colors.blue)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
            content: Text(mensaje));
      });
}
