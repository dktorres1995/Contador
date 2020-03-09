import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/pathProvider.dart';
import 'dart:convert';

class Galeria extends StatefulWidget {
  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listaPath(),
      builder: (context,lista){
        List<dynamic> listajson = json.decode(lista.data); 
        List<dynamic> listaPaths = listajson.first['files'];
        print(listaPaths.first.toString());
        return imprimirPath(lista.data);
      },
    );
  }
}


Widget imprimirPath(String pathlist){

  return SingleChildScrollView(child: Column(children: <Widget>[
    Text(pathlist)
  ],),);
}