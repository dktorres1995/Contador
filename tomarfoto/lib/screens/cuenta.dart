import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';

class CuentaScreen extends StatefulWidget {
  static const routedName = "/cuentaScreen";
  @override
  _CuentaScreenState createState() => _CuentaScreenState();
}

class _CuentaScreenState extends State<CuentaScreen> {
  @override
  Widget build(BuildContext context) {
    return ContenidoPagina(
      contenido: Center(
        child: Text('aqui va lo referente a la cuenta'),
      ),
      titulo: 'Cuenta',
      bloqueo: false,confirmacionSalida: false,mensajeConfirmacionSalida: (){},
    );
  }
}
