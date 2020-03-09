
import 'package:flutter/material.dart';
import 'package:tomarfoto/routes/routes.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';
import 'package:tomarfoto/mixis/mixis_block_screen.dart';
void main() => runApp(CameraApp());

class CameraApp extends StatelessWidget with PortraitModeMixin {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConteoAppV1',
        theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.indigo[900],
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

