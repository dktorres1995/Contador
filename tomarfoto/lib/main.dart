
import 'package:flutter/material.dart';
import 'package:tomarfoto/routes/routes.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';

void main() => runApp(CameraApp());

class CameraApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConteoAppV1',
        theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue[500],
      ),
      initialRoute: '/',//CameraExampleHome(cameras),
      routes: getAplicaciones(),
      onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: (ctx) => PantallaInicial()
        );
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(
          builder: (ctx) => PantallaInicial()
        );
      }
    );
  }
}

