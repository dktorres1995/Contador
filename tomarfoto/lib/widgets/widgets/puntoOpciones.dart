import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/historial.dart';

class Puntos extends StatelessWidget {
  final String nombre;
  final Function eliminar;
  final Function actualizar;
  final TextEditingController nombreConteo;
  final double tam;
  Puntos(
      {this.nombre,
      this.eliminar,
      this.actualizar,
      this.nombreConteo,
      this.tam});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.more_horiz,
        size: tam,
      ),
      onTap: () {
        print('oprimio');
        showBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
          ),
          context: context,
          builder: (context) {
            return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                      new BorderRadius.vertical(top: Radius.circular(40.0)),
                ),
                height: 220.0,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Divider(
                      height: 30.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(40.0)),
                      height: 180.0,
                      width: 350,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                              title: Text(
                                'Eliminar del historial',
                                style: TextStyle(color: Colors.red),
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
                                              Navigator.of(context).pushNamed(
                                                  Historial.routedName);
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }),
                          Divider(
                            color: Colors.black,
                            height: 1,
                          ),
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
                                      titlePadding:
                                          EdgeInsets.only(left: 50, top: 10),
                                      title: Text("Cambiar Nombre"),
                                      content: TextField(
                                        controller: nombreConteo,
                                        decoration: InputDecoration(
                                            hintText: "Nombre",
                                            fillColor: Color(0X1F000000),
                                            filled: true),
                                      ),
                                      actions: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: new FlatButton(
                                            child: new Text(
                                              'Cancelar',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: FlatButton(
                                            child: new Text('Aceptar'),
                                            onPressed: () {
                                              actualizar();
                                              Navigator.of(context).pushNamed(
                                                  Historial.routedName);
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                          Divider(
                            color: Colors.black,
                            height: 1,
                          ),
                          ListTile(
                              title: Text(
                                'Cerrar',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () => Navigator.of(context).pop()),
                        ],
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }
}
