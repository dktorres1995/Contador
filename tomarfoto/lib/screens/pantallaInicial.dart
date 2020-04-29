import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/historial.dart';

class PantallaInicial extends StatefulWidget {
  static const routedName = '/pantallaInicial';
  @override
  _State createState() => _State();
}

class _State extends State<PantallaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrains) {
        return Container(
          color: Theme.of(context).accentColor,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  height: constrains.maxHeight * 0.8,
                  width: constrains.maxWidth,
                  decoration: BoxDecoration(
                      color: Colors.indigo[800], shape: BoxShape.circle),
                ),
              ),
              Center(
                child: Container(
                  height: constrains.maxHeight * 0.4,
                  width: constrains.maxWidth,
                  decoration: BoxDecoration(
                      color: Colors.indigo[700], shape: BoxShape.circle),
                ),
              ),
              Center(
                  child: InkWell(
                      child: Text(
                'NUMERATE',
                style: TextStyle(color: Colors.white,fontSize: 20),
              ),onTap: ()=>Navigator.of(context)
            .pushNamed(Historial.routedName)) //botonesIniciales(context),
                  ),
            ],
          ),
        );
      }),
    );
  }
}