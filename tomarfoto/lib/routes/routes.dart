import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/Espera.dart';
import 'package:tomarfoto/screens/cuenta.dart';
import 'package:tomarfoto/screens/detalleImagen.dart';
import 'package:tomarfoto/screens/historial.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';
import 'package:tomarfoto/screens/envioImagen2.dart';
import 'package:tomarfoto/screens/instructivo.dart';

Map<String, WidgetBuilder> getAplicaciones() {
  return <String, WidgetBuilder>{
    PantallaInicial.routedName: (ctx) => PantallaInicial(),
    Historial.routedName: (ctx) => Historial(),
    EnvioImagen2.routedName: (ctx) => EnvioImagen2(),
    InstructivoScreen.routedName: (ctx) => InstructivoScreen(),
    DetalleImagen.routedName: (ctx) => DetalleImagen(),
    EsperaScreen.routedName: (ctx) => EsperaScreen(),
    CuentaScreen.routedName: (ctx)=> CuentaScreen()
  };
}
