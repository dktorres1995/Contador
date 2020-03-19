import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';

class InstructivoScreen extends StatefulWidget {
  static const routedName = '/Instructivo';
  @override
  _InstructivoScrrenState createState() => _InstructivoScrrenState();
}

class _InstructivoScrrenState extends State<InstructivoScreen> {
  @override
  Widget build(BuildContext context) {
    return ContenidoPagina(
        contenido: Center(child: Text('aqui iria el instructivo')),
        titulo: 'Inicio',
        bloqueo: false);
  }
}
