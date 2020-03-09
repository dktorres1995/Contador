import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/TraerInfo.dart';
import 'package:tomarfoto/screens/envioImagen.dart';

class PantallaInicial extends StatefulWidget {
  static const routedName = '/';
  @override
  _State createState() => _State();
}

class _State extends State<PantallaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 200,
                height: 50,
                child: SafeArea(
                    child: Text(
                  'inicial',
                  textAlign: TextAlign.center,
                ))),
            InkWell(
              child: Container(
                height: 60,
                width: 200,
                child: Card(
                  elevation: 20,
                  child: SafeArea(
                      child: Text(
                    'ir a foto',
                    textAlign: TextAlign.center,
                  )),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(EnvioImagen.routedName),
            ),
            InkWell(
              child: Container(
                height: 60,
                width: 200,
                child: Card(
                  elevation: 20,
                  child: SafeArea(
                      child: Text(
                    'ver la info de una foto',
                    textAlign: TextAlign.center,
                  )),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(MyApp.routedName,arguments: fetchPost()),
            )
          ],
        ),
      ),
    );
  }
}
