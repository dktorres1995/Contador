import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';

class EsperaScreen extends StatelessWidget {
  static const routedName = '/espera';
  @override
  Widget build(BuildContext context) {
    return ContenidoPagina(
        contenido: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Cargando...',
                style: TextStyle(color: Colors.white),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            ],
          ),
        ),
        titulo: 'Espera',
        bloqueo: true,confirmacionSalida: false,mensajeConfirmacionSalida: (){});
  }
}
