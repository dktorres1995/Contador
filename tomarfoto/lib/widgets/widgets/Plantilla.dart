import 'package:flutter/material.dart';
import 'package:Numerate/routes/routes.dart';
import 'package:Numerate/screens/cuenta.dart';
import 'package:Numerate/screens/envioImagen2.dart';
import 'package:Numerate/screens/historial.dart';
import 'package:Numerate/screens/instructivo.dart';

class ContenidoPagina extends StatelessWidget {
  final Widget contenido;
  final String titulo;
  final bool bloqueo; //bloquear botontes
  bool confirmacionSalida;
  Function mensajeConfirmacionSalida;
  ContenidoPagina(
      {@required this.contenido,
      @required this.titulo,
      @required this.bloqueo,
      @required this.confirmacionSalida,
      @required this.mensajeConfirmacionSalida});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: getAplicaciones(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.indigo[900],
      ),
      home: Scaffold(resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(titulo),
            centerTitle: true,
            backgroundColor: Theme.of(context).accentColor,
          ),
          body: LayoutBuilder(
            builder: (ctx, constrains) {
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                          width: constrains.maxWidth,
                          height: constrains.maxHeight * 0.9,
                          child: contenido),
                      Container(
                        width: constrains.maxWidth,
                        height: constrains.maxHeight * 0.1,
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: constrains.maxWidth * 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  child: Icon(Icons.home,
                                      color: Theme.of(context).accentColor),
                                  onTap: () {
                                    if (!bloqueo & !confirmacionSalida) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              InstructivoScreen.routedName,
                                              (ro) => false);
                                    }
                                    if (confirmacionSalida) {
                                      mensajeConfirmacionSalida();
                                    }
                                  },
                                ),
                                Container(
                                  width: constrains.maxWidth * 0.1,
                                ),
                                InkWell(
                                  child: Icon(Icons.history,
                                      color: Theme.of(context).accentColor),
                                  onTap: () {
                                    if (!bloqueo & !confirmacionSalida) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              Historial.routedName,
                                              (ro) => false);
                                    }
                                    if (confirmacionSalida) {
                                      mensajeConfirmacionSalida();
                                    }
                                  },
                                ),
                                Container(width: constrains.maxWidth * 0.5),
                                InkWell(
                                  child: Icon(
                                    Icons.person,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  onTap: () {
                                    if (!bloqueo & !confirmacionSalida) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              CuentaScreen.routedName,
                                              (ro) => false);
                                    }
                                    if (confirmacionSalida) {
                                      mensajeConfirmacionSalida();
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: constrains.maxWidth * 0.45,
                        top: constrains.maxHeight * 0.86),
                    child: FloatingActionButton(heroTag: 'boton_foto',
                      elevation: 20,
                      tooltip: 'toma una foto',
                      child: Icon(Icons.photo_camera,
                          color: Theme.of(context).accentColor),
                      backgroundColor: Colors.white,
                      onPressed: () {
                        if (!bloqueo & !confirmacionSalida) {
                          Navigator.of(context)
                              .pushNamed(EnvioImagen2.routedName);
                        }
                        if (confirmacionSalida) {
                          mensajeConfirmacionSalida();
                        }
                      },
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}

Widget circulo(BoxConstraints medida, double pW, double marg, Widget contenido,
    Color colorFondo, Color colorBorde) {
  return Container(
    decoration: BoxDecoration(
        color: colorBorde, borderRadius: BorderRadius.circular(80)),
    margin: EdgeInsets.all(medida.maxWidth * marg),
    height: medida.maxWidth * pW, //medida.maxHeight * pH,
    width: medida.maxWidth * pW,

    child: Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: colorFondo, borderRadius: BorderRadius.circular(80)),
      child: contenido,
    ),
  );
}
