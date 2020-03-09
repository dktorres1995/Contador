import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';
import 'package:tomarfoto/screens/TraerInfo.dart';
import 'package:tomarfoto/screens/envioImagen.dart';

Map <String,WidgetBuilder> getAplicaciones(){
  return <String,WidgetBuilder>{
    PantallaInicial.routedName      : (ctx) =>  PantallaInicial(),
      EnvioImagen.routedName        : (ctx)=> EnvioImagen(),
    MyApp.routedName            : (ctx)=>MyApp()
  };
}