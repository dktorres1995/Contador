import 'dart:io';
import 'package:image/image.dart' as LibIma;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/envioImagen.dart';

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
        title: Text('NUMERATE'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchPost(id),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            print(snapshot.data[1]);
            if (snapshot.hasData) {
              var image3 =
            LibIma.decodeJpg((snapshot.data[1] as http.Response).bodyBytes);
        print('alto: ${image3.height} ancho: ${image3.width}');
        for (int i = 1; i < 10; i++) {
          print('${(snapshot.data[0].centros as List<dynamic>).elementAt(0)['x']}');
          image3 = LibIma.drawCircle(image3, (snapshot.data[0].centros as List<dynamic>).elementAt(0)['x'], (snapshot.data[0].centros as List<dynamic>).elementAt(0)['y'], 20 + i,
              LibIma.getColor(255, 0, 0)); // coordenadas imagen
          image3 = LibIma.drawCircle(
              image3, 2543, 785, 40 + i, LibIma.getColor(255, 0, 0));
        }
        return FutureBuilder(
           future: ruta(),
           builder: (context, info) {
              if (info.hasData) {
              File(info.data ).writeAsBytesSync(LibIma.encodeJpg(image3));
              return SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                   GestureDetector(child: 
                   Image.file(File(info.data)),
                    ),
                    ClipOval(
                        child: Container(
                            color: Colors.grey.withOpacity(0.9),
                            height: 50.0, // height of the button
                            width: 50.0,
                            child: Align(
                              child: Center(
                                  child: Text('${snapshot.data[0].conteo}')),
                            ))),                     
                  ],
                ),
              );}

                return CircularProgressIndicator(
              backgroundColor: Colors.green,
            );
              }
             
              );
            } else if (snapshot.hasError) {
              return CircularProgressIndicator();
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
