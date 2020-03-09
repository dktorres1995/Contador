import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/historial.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';
import 'package:tomarfoto/screens/cameraHome.dart';
import 'package:tomarfoto/screens/TraerInfo.dart';

Map <String,WidgetBuilder> getAplicaciones(){
  return <String,WidgetBuilder>{
    PantallaInicial.routedName      : (ctx) =>  PantallaInicial(),
    CameraExampleHome.routedName    : (ctx)=> CameraExampleHome(),
    MyApp.routedName            : (ctx)=>MyApp(),
    Historial.routedName            : (ctx)=>Historial()
  };
}