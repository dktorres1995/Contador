import 'dart:io';
import 'package:flutter/material.dart';

class VisualizacionFotoTomada extends StatefulWidget {
  String pathDeFoto;
  VisualizacionFotoTomada(this.pathDeFoto);

  @override
  _VisualizacionFotoTomadaState createState() =>
      _VisualizacionFotoTomadaState();
}

class _VisualizacionFotoTomadaState extends State<VisualizacionFotoTomada> {
  @override
  Widget build(BuildContext context) {
    return widget.pathDeFoto == ''
        ? Center(
            child: Text('no hay imagen'),
          )
        : SizedBox(child: Image.file(File(widget.pathDeFoto)));
  }
}
