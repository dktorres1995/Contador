import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/historial.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';
import 'package:tomarfoto/screens/TraerInfo.dart';
import 'package:tomarfoto/screens/envioImagen.dart';
import 'package:tomarfoto/screens/envioImagen2.dart';

Map <String,WidgetBuilder> getAplicaciones(){
  return <String,WidgetBuilder>{
    PantallaInicial.routedName      : (ctx) =>  PantallaInicial(),
    EnvioImagen.routedName        : (ctx)=> EnvioImagen(),
    MyApp.routedName            : (ctx)=> MyApp(),
    Historial.routedName            : (ctx)=>Historial(),
    EnvioImagen2.routedName         : (ctx)=>EnvioImagen2()
  };
}