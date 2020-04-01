import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as LibIma;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tomarfoto/Models/Recursos.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';
import 'package:zoom_widget/zoom_widget.dart';

class MyApp extends StatefulWidget {
  static const routedName = '/TraerInfo';
  final String id;
  final List<dynamic> listaPuntos;
  final Function eliminarEtiquetas;
  final Function anadirEtiquetas;
  MyApp(
      {@required this.id,
      @required this.listaPuntos,
      @required this.anadirEtiquetas,
      @required this.eliminarEtiquetas});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _editar = false;
  bool _eliminar = false;
  LibIma.Image imageMostrar;
  int cambioConteo = 0;
  List<dynamic> listaAdibujar = List<dynamic>();

  void cambiarEditar(bool estado) {
    setState(() {
      if (!_editar) {
        _editar = estado;
        _eliminar = !estado;
      } else {
        _editar = false;
      }
    });
  }

  void cambiarEliminar(bool estado) {
    setState(() {
      if (!_eliminar) {
        _eliminar = estado;
        _editar = !estado;
      } else {
        _eliminar = false;
      }
    });
  }

  double distanciaEuclidiana(int dx, int dy) {
    return sqrt(pow(dx, 2) + pow(dy, 2));
  }

  void modificar(int x, int y, bool _eliminar) {
    var menorDistancia = double.infinity;
    double dist = 0;
    var xIn = 0;
    var yIn = 0;

    if (_eliminar) {
      for (var coordenada in listaAdibujar) {
        dist = distanciaEuclidiana(coordenada['x'] - x, coordenada['y'] - y);
        if (dist < menorDistancia) {
          menorDistancia = dist;
          xIn = coordenada['x'];
          yIn = coordenada['y'];
        }
      }

      setState(() {
        var indiceAgregada = -1;
        var conteo = 0;
        listaAdibujar.forEach((element) {
          if (mapEquals({'x': xIn, 'y': yIn, 'estado': 'agregada'}, element)) {
            indiceAgregada = conteo;
          }
          conteo++;
        });

        var indiceSistema = -1;
        conteo = 0;
        listaAdibujar.forEach((element) {
          if (mapEquals({'x': xIn, 'y': yIn, 'estado': 'sistema'}, element)) {
            indiceSistema = conteo;
          }
          conteo++;
        });

        if (indiceAgregada != -1) {
          listaAdibujar.removeAt(indiceAgregada);
          List<Map<String, int>> listaAgregada = List<Map<String, int>>();
          listaAdibujar.forEach((element) {
            if (element['estado'] == 'agregada') {
              listaAgregada.add({'x': element['x'], 'y': element['y']});
            }
          });
          widget.anadirEtiquetas(listaAgregada);
        } else if (indiceSistema != -1) {
          print('este elimino');
          listaAdibujar.removeAt(indiceSistema);
          widget.eliminarEtiquetas(xIn, yIn);
          listaAdibujar.add({'x': xIn, 'y': yIn, 'estado': 'eliminada'});
        }
        cambioConteo--;
      });
    } else if (_editar) {
      setState(() {
        listaAdibujar.add({'x': x, 'y': y, 'estado': 'agregada'});
        List<Map<String, int>> listaAgregada = List<Map<String, int>>();
        listaAdibujar.forEach((element) {
          if (element['estado'] == 'agregada') {
            listaAgregada.add({'x': element['x'], 'y': element['y']});
          }
        });
        widget.anadirEtiquetas(listaAgregada);
        cambioConteo++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print('contruye---------------------------------');
    setState(() {
      imageMostrar =
          LibIma.decodeJpg((widget.listaPuntos[1] as http.Response).bodyBytes);

      for (var coor in (widget.listaPuntos[0] as Recursos).centros) {
        listaAdibujar
            .add({'x': coor['x'], 'y': coor['y'], 'estado': 'sistema'});
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
              Zoom(
                  zoomSensibility: 2,
                  backgroundColor: Colors.white,
                  initZoom: 0.0,
                  width: imageMostrar.width.toDouble(),
                  height: imageMostrar.height.toDouble(),
                  child: GestureDetector(
                    child: Container(
                      height: imageMostrar.height.toDouble(),
                      width: imageMostrar.width.toDouble(),
                      child: Stack(
                        children: <Widget>[
                          Image.network(widget.listaPuntos[0].imagenUrl),
                          // Image.memory(LibIma.encodeJpg(imageMostrar)),
                          CustomPaint(
                            size: Size(imageMostrar.width.toDouble(),
                                imageMostrar.height.toDouble()),
                            painter: new MyPainter(
                                (widget.listaPuntos[0] as Recursos).radio,
                                listaAdibujar,
                                imageMostrar.width.toDouble() * 0.0025),
                          )
                        ],
                      ),
                    ),
                    onTapDown: (dato) {
                      if (_editar) {
                        modificar(dato.localPosition.dx.toInt(),
                            dato.localPosition.dy.toInt(), false);
                      }
                      if (_eliminar &&
                          (widget.listaPuntos[0].conteo + cambioConteo) > 0) {
                        modificar(dato.localPosition.dx.toInt(),
                            dato.localPosition.dy.toInt(), true);
                      }
                    },
                  )),
              Container(
                margin: EdgeInsets.all(medida.maxHeight * 0.05),
                height: medida.maxHeight * 0.12,
                width: medida.maxHeight * 0.12,
                child: FloatingActionButton(
                  elevation: 30,
                  heroTag: 'cuenta',
                  child: Center(
                      child: Text(
                    '${widget.listaPuntos[0].conteo + cambioConteo}',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: medida.maxHeight * 0.05),
                  )),
                  backgroundColor: Colors.white,
                  onPressed: () {},
                ),
              ),
              Container(
                height: medida.maxHeight,
                width: medida.maxWidth,
                margin: EdgeInsets.only(
                    top: medida.maxHeight * 0.75,
                    left: medida.maxWidth * 0.8,
                    bottom: medida.maxHeight * 0.025),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: 'boton_mas',
                      elevation: 20,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: medida.maxWidth * 0.1,
                          color: _editar
                              ? Colors.white
                              : Theme.of(context).accentColor,
                        ),
                      ),
                      backgroundColor: _editar
                          ? Theme.of(context).accentColor
                          : Colors.white,
                      onPressed: () {
                        print('cambiar');
                        cambiarEditar(_editar ? false : true);
                      },
                    ),
                    FloatingActionButton(
                      heroTag: 'boton_menos',
                      elevation: 20,
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          size: medida.maxWidth * 0.1,
                          color: _eliminar
                              ? Colors.white
                              : Theme.of(context).accentColor,
                        ),
                      ),
                      backgroundColor: _eliminar
                          ? Theme.of(context).accentColor
                          : Colors.white,
                      onPressed: () {
                        print('elimianr');
                        cambiarEliminar(_eliminar ? false : true);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class MyPainter extends CustomPainter {
  //         <-- CustomPainter class

  double radio;
  List<dynamic> centros = List<dynamic>();
  double grosor;
  MyPainter(this.radio, this.centros, this.grosor);
  @override
  void paint(Canvas canvas, Size size) {
    var center;
    var paint = Paint();
    for (var coordenada in centros) {
      center = Offset(coordenada['x'].toDouble(), coordenada['y'].toDouble());
      paint
        ..color = coordenada['estado'] == 'sistema'
            ? Color(0x8F0000A0)
            : coordenada['estado'] == 'agregada'
                ? Color(0x8F00FF00)
                : coordenada['estado'] == 'eliminada'
                    ? Color(0x00000000)
                    : Colors.black
        ..style = PaintingStyle.fill
        ..strokeWidth = grosor;
      canvas.drawCircle(center, radio, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
