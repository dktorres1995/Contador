import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tomarfoto/Models/Recursos.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/envioImagen.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';

class MyApp extends StatefulWidget {
  static const routedName = '/TraerInfo';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('númerar'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Center(
        child: FutureBuilder<Recursos>(
          future: fetchPost(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Image.network(snapshot.data.imagenUrl),
                    ClipOval(
                        child: Container(
                            color: Colors.grey.withOpacity(0.9),
                            height: 50.0, // height of the button
                            width: 50.0,
                            child: Align(
                              child: Center(
                                  child: Text('${snapshot.data.conteo}')),
                            ))),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // Por defecto, muestra un loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(EnvioImagen.routedName),
        child: Container(
          child: Icon(
            Icons.camera_alt,
            color: Theme.of(context).accentColor,
          ),
        ),
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
}
