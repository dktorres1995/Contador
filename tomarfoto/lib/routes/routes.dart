import 'package:flutter/material.dart';
import '../screens/Espera.dart';
import '../screens/PantallaWeb.dart';
import '../screens/cuenta.dart';
import '../screens/detalleImagen.dart';
import '../screens/historial.dart';
import '../screens/pantallaInicial.dart';
import '../screens/envioImagen2.dart';
import '../screens/instructivo.dart';
import '../screens/PantallaWebAux.dart';
import '../screens/PantallaWebEdicion.dart';
import '../screens/cuenta2.dart';

Map<String, WidgetBuilder> getAplicaciones() {
  return <String, WidgetBuilder>{
    PantallaInicial.routedName: (ctx) => PantallaInicial(),
    Historial.routedName: (ctx) => Historial(),
    EnvioImagen2.routedName: (ctx) => EnvioImagen2(),
    InstructivoScreen.routedName: (ctx) => InstructivoScreen(),
    DetalleImagen.routedName: (ctx) => DetalleImagen(),
    EsperaScreen.routedName: (ctx) => EsperaScreen(),
    CuentaScreen.routedName: (ctx)=> CuentaScreen(),
    PantallaWeb.routedname: (ctx)=>PantallaWeb(),
    PantallaWebAux.routedname:(ctx)=>PantallaWebAux(),
    PantallaWebEdicion.routedname:(ctx)=>PantallaWebEdicion(),
    CuentaScreen2.routedName: (ctx)=> CuentaScreen2(),
  };
}
