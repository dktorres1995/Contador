import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';
import 'package:tomarfoto/screens/cameraHome.dart';
import 'package:tomarfoto/screens/TraerInfo.dart';

Map <String,WidgetBuilder> getAplicaciones(){
  return <String,WidgetBuilder>{
    PantallaInicial.routedName      : (ctx) =>  PantallaInicial(),
    CameraExampleHome.routedName    : (ctx)=> CameraExampleHome(),
    TraerInfo.routedName            : (ctx)=>TraerInfo()
  };
}