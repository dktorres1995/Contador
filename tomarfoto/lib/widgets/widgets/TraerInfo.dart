import 'dart:io';
import 'package:image/image.dart' as LibIma;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zoom_widget/zoom_widget.dart';

class MyApp extends StatefulWidget {
  static const routedName = '/TraerInfo';
  final String id;
  final List<dynamic> listaPuntos;
  MyApp({this.id, this.listaPuntos});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, int>> prueba = List<Map<String, int>>();
  double _zoom = 0;
  double _scale = 0;
  double _offsetX = 0;
  double _offsetY = 0;
  LibIma.Image imageMostrar;

  void cambiaScalayZoom(double scale, double zoom) {
    setState(() {
      _zoom = zoom;
      _scale = scale;
    });
  }

  void cambiaOffset(double x, double y) {
    setState(() {
      _offsetX = x;
      _offsetY = y;
    });
  }

  void modificar(int dx, int dy) {
    var xIn = (_offsetX + _scale * dx.toDouble()).toInt();
    var yIn = (_offsetY + _scale * dy.toDouble()).toInt();
    setState(() {
      prueba.add({'x': xIn, 'y': yIn});
      for (var coord in prueba) {
        imageMostrar = LibIma.drawCircle(imageMostrar, coord['x'], coord['y'],
            widget.listaPuntos[0].radio.toInt(), LibIma.getColor(255, 0, 0));
      }
    });
    print(prueba);
  }

  @override
  void initState() {
    super.initState();
    print('contruye---------------------------------');
    setState(() {
      imageMostrar =
          LibIma.decodeJpg((widget.listaPuntos[1] as http.Response).bodyBytes);

      //dibuja de lo que trae de internet
      for (var coordenada in widget.listaPuntos[0].centros) {
        imageMostrar = LibIma.drawCircle(
            imageMostrar,
            coordenada['x'],
            coordenada['y'],
            widget.listaPuntos[0].radio.toInt(),
            LibIma.getColor(0, 255, 255));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //dibuja de lo colocado en pantalla

    return LayoutBuilder(
      builder: (context, medida) {
        return Container(
          height: medida.maxHeight,
          width: medida.maxWidth,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  height: medida.maxHeight * 0.5,
                  width: medida.maxWidth,
                  child: Zoom(
                      initZoom: 0.0,
                      width: imageMostrar.width.toDouble(),
                      height: imageMostrar.height.toDouble(),
                      onPositionUpdate: (Offset position) {
                        // print('${position.dx} ' + '${position.dy}');
                        //cambiaOffset(position.dx, position.dy);
                      },
                      onScaleUpdate: (double scale, double zoom) {
                        //print("escala: $scale y zoom:  $zoom");
                        // cambiaScalayZoom(scale, zoom);
                      },
                      child: Center(
                        child: Image.memory(LibIma.encodeJpg(imageMostrar)),
                      )),
                ),
                onTapDown: (dato) {
                  modificar(dato.localPosition.dx.toInt(),
                      dato.localPosition.dy.toInt());
                },
                onTapUp: (dato) {
                  modificar(dato.localPosition.dx.toInt(),
                      dato.localPosition.dy.toInt());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/*
                              ClipOval(
                                  child: Container(
                                      color: Colors.grey.withOpacity(0.9),
                                      height: 200, // height of the button
                                      width: 200,
                                      child: Align(
                                        child: Center(
                                            child: Text('gesture-> X:$xgestu Y:$ygestu \n zoom-> X:$xzoom Y:$yzoom')),
                                      ))),*/
//Text('${snapshot.data[0].conteo}')

/* var image3 =
                LibIma.decodeJpg((snapshot.data[1] as http.Response).bodyBytes);

            //dibuja de lo que trae de internet
            for (var coordenada in snapshot.data[0].centros) {
              image3 = LibIma.drawCircle(
                  image3,
                  coordenada['x'],
                  coordenada['y'],
                  snapshot.data[0].radio.toInt(),
                  LibIma.getColor(0, 255, 255));
            }
            //dibuja de lo colocado en pantalla
            if (prueba.isNotEmpty) {
              for (var coord in prueba) {
                image3 = LibIma.drawCircle(image3, coord['x'], coord['y'],
                    snapshot.data[0].radio.toInt(), LibIma.getColor(255, 0, 0));
              }

               File(info.data).writeAsBytesSync(LibIma.encodeJpg(image3));
                    return LayoutBuilder(
                      builder: (context, medida) {
                        return Container(
                          height: medida.maxHeight,
                          width: medida.maxWidth,
                          child: Stack(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  height: medida.maxHeight * 0.5,
                                  width: medida.maxWidth,
                                  child: Zoom(
                                      initZoom: 0.0,
                                      width: image3.width.toDouble(),
                                      height: image3.height.toDouble(),
                                      onPositionUpdate: (Offset position) {
                                        print('${position.dx} ' +
                                            '${position.dy}');
                                        cambiaOffset(position.dx, position.dy);
                                      },
                                      onScaleUpdate:
                                          (double scale, double zoom) {
                                        print("escala: $scale y zoom:  $zoom");
                                        cambiaScalayZoom(scale, zoom);
                                      },
                                      child: Center(
                                        child: Image.file(File(info.data)),
                                      )),
                                ),
                                onTapDown: (dato) {
                                  modificar(dato.localPosition.dx.toInt(),
                                      dato.localPosition.dy.toInt());
                                },
                                onTapUp: (dato) {
                                  modificar(dato.localPosition.dx.toInt(),
                                      dato.localPosition.dy.toInt());
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
            }*/
