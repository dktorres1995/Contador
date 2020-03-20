import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/historial.dart';

class Puntos extends StatelessWidget {
  final String nombre;
  final Function eliminar;
  final Function actualizar;
  final TextEditingController nombreConteo;
  final double tam;
  Puntos({this.nombre, this.eliminar, this.actualizar, this.nombreConteo,this.tam});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(Icons.more_horiz,size: tam,),
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                height: 200.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                        title: Text(
                          'Eliminar del historial',
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Eliminar "),
                                  content: Text(
                                      '¿Esta seguro que desea eliminar ? \n $nombre'),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text('Aceptar'),
                                      onPressed: () {
                                        eliminar();
                                        Navigator.of(context)
                                            .pushNamed(Historial.routedName);
                                      },
                                    )
                                  ],
                                );
                              });
                        }),
                    ListTile(
                      title: Text(
                        'Cambiar Nombre',
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Cambiar Nombre"),
                                content: TextField(
                                  controller: nombreConteo,
                                  decoration:
                                      InputDecoration(hintText: "Nombre"),
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  new FlatButton(
                                    child: new Text('Aceptar'),
                                    onPressed: () {
                                      actualizar();
                                      Navigator.of(context)
                                          .pushNamed(Historial.routedName);
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                    ListTile(
                        title: Text(
                          'Cerrar',
                          textAlign: TextAlign.center,
                        ),
                        onTap: () => Navigator.of(context).pop()),
                  ],
                ));
          },
        );
      },
    );
  }
}
