import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tomarfoto/Models/Recursos.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/TraerInfo.dart';
import 'package:tomarfoto/screens/envioImagen.dart';

class Historial extends StatelessWidget {
  static const routedName = '/historial';
  final opciones = ['uno', 'dos'];
  List<int> _listaNumeros = [1, 2, 3, 4, 5];
   
  @override
  Widget build(BuildContext context) {
   final Future<List<Recursos>> listaObtenida =  ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Númerar'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Center(
          child: FutureBuilder(
              future: listaObtenida,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 17.0, 0.0, 0.0),
                    child: crear(snapshot.data,context),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Container(
          child: Icon(
            Icons.camera_alt,
            color: Theme.of(context).accentColor,
          ),
        ),
        onPressed: () =>
            Navigator.of(context).pushNamed(EnvioImagen.routedName),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          color: Theme.of(context).accentColor,
          height: 50.0,
        ),
      ),
    );
  }

  Widget crear(List<Recursos> lista,BuildContext ctx) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network(
            lista[index].imagenUrl,
            width: 100.0,
            height: 50.0,
          ),
          title: Text('Varillas conteo ' +
              (index + 1).toString() +
              '           ' +
              lista[index].conteo.toString()),
          onTap: () => Navigator.of(ctx)
              .pushNamed(MyApp.routedName, arguments: lista[index].id),
        );
      },
    );
  }
}
