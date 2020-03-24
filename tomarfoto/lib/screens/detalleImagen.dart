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

  void addEtiquetas(int x, int y) {
    etAgregadas.add({'x': x, 'y': y});

    print('agregadas $etAgregadas');
  }

  void eliminadasEtiquetas(int x, int y) {
    etEliminadas.add({'x': x, 'y': y});

    print('eliminadas $etEliminadas');
  }

  void compararEtiquetas(){
    
  }

  void enviarTodo(String id, BuildContext ctx) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(EsperaScreen.routedName);
    anadirEtiquetas(etAgregadas, id).then((res) {
      print('enviadas');
      eliminarEtiquetas(etEliminadas, id).then((res) {
        print('enviadas para eliminar');
      
        Navigator.of(context).pushNamed(Historial.routedName);
        mensaje(ctx, 'Cambios realizados',
            'sus cambios se han guardado exitosamente');
      }).catchError((onError) {
        Navigator.of(context).pushNamed(Historial.routedName);
        mensaje(
            ctx, 'Error', 'Hubo un error al enviar los conteos descartados');
      });
    }).catchError((onError) {
      Navigator.of(context).pushNamed(Historial.routedName);
      mensaje(ctx, 'Error', 'Hubo un error al enviar los conteos añadidos');
    });
  }
  
  void mensajeConfirmacionEnvio(String id, BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "¿descartar cambios? ",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  child: Text('Guardar Cambios',
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  onTap: () => enviarTodo(id, ctx),
                ),
                Divider(
                  height: 20,
                ),
                InkWell(
                  child: Text('Descartar Cambios',
                      style: TextStyle(color: Colors.red)),
                  onTap: () =>
                      Navigator.of(context).pushNamed(Historial.routedName),
                ),
                Divider(
                  height: 20,
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
