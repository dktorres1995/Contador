import 'package:flutter/material.dart';

class TraerInfo extends StatefulWidget {
  static const routedName = '/TraerInfo';
  @override
  _TraerInfoState createState() => _TraerInfoState();
}

class _TraerInfoState extends State<TraerInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mostrar Info'),
      ),body: Center(child: Text('aqui se ve la foto y los resultados'),),
    );
  }
}
