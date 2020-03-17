import 'package:flutter/material.dart';
import 'package:tomarfoto/routes/routes.dart';
import 'package:tomarfoto/screens/envioImagen2.dart';
import 'package:tomarfoto/screens/historial.dart';

class InstructivoScreen extends StatefulWidget {
  static const routedName = '/Instructivo';
  @override
  _InstructivoScrrenState createState() => _InstructivoScrrenState();
}

class _InstructivoScrrenState extends State<InstructivoScreen> {
 

  @override
  Widget build(BuildContext context) {
    return  contenidoPagina(
          Center(child: Text('aqui iria el instructivo')), 'Inicio',context);
  }
}
 Widget contenidoPagina(Widget contenido, String titulo,BuildContext context) {
    return MaterialApp(routes: getAplicaciones(),
          home: Scaffold(
          appBar: AppBar(
            title: Text(titulo),
            centerTitle: true,
            backgroundColor: Theme.of(context).accentColor,
          ),
          body: LayoutBuilder(
            builder: (ctx, constrains) {
              return Column(
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
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              width: constrains.maxWidth * 0.3,
                              height: constrains.maxHeight * 0.1,
                              child: Icon(Icons.home,
                                  color: Theme.of(context).accentColor),
                            ),
                            onTap: () => Navigator.of(context)
                                .pushNamed(InstructivoScreen.routedName),
                          ),
                          InkWell(
                            child: Container(
                              width: constrains.maxWidth * 0.3,
                              height: constrains.maxHeight * 0.1,
                              child: Icon(Icons.history,
                                  color: Theme.of(context).accentColor),
                            ),
                            onTap: () => Navigator.of(context)
                                .pushNamed(Historial.routedName),
                          ),
                          InkWell(
                            child: Container(
                              width: constrains.maxWidth * 0.3,
                              height: constrains.maxHeight * 0.1,
                              child: Icon(Icons.photo_camera,
                                  color: Theme.of(context).accentColor),
                            ),
                            onTap: () => Navigator.of(context)
                                .pushNamed(EnvioImagen2.routedName),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }