import 'dart:math';

import 'package:image/image.dart' as LibIma;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';
import 'package:zoom_widget/zoom_widget.dart';

class MyApp extends StatefulWidget {
  static const routedName = '/TraerInfo';
  final String id;
  final List<dynamic> listaPuntos;
  final Function eliminarEtiquetas;
  final Function anadirEtiquetas;
  final List<Map<String, int>> listaEditada = new List<Map<String, int>>();
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

  void cambiarEditar(bool estado) {
    setState(() {
      
      if(!_editar){
       _editar = estado;
       _eliminar = !estado;}
      else{
        _editar = false;
      } 
    });
  }

  void cambiarEliminar(bool estado) {
    setState(() {
      if(!_eliminar){
      _eliminar = estado;
      _editar = !estado;}
      else{
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
      for (var coordenada in widget.listaPuntos[0].centros) {
        dist = distanciaEuclidiana(coordenada['x'] - x, coordenada['y'] - y);
        if (dist < menorDistancia) {
          menorDistancia = dist;
          xIn = coordenada['x'];
          yIn = coordenada['y'];
        }
      }

      widget.listaEditada.add({'x': xIn, 'y': yIn});

      setState(() {
        widget.eliminarEtiquetas(xIn, yIn);
        imageMostrar = LibIma.drawCircle(imageMostrar, xIn, yIn,
            widget.listaPuntos[0].radio.toInt(), LibIma.getColor(255, 0, 0));
        cambioConteo--;
      });
      //print('eliminadas $etEliminadas');
    } else if (_editar) {
      setState(() {
        widget.anadirEtiquetas(x, y);
        imageMostrar = LibIma.drawCircle(imageMostrar, x, y,
            widget.listaPuntos[0].radio.toInt(), LibIma.getColor(0, 255, 0));
        cambioConteo++;
      });
      //print('agregadas $etAgregadas');
    }
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
            LibIma.getColor(0, 0, 255));
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
                  backgroundColor: Colors.white,
                  initZoom: 0.0,
                  width: imageMostrar.width.toDouble(),
                  height: imageMostrar.height.toDouble(),
                  child: GestureDetector(
                    child: Container(
                      height: imageMostrar.height.toDouble(),
                      width: imageMostrar.width.toDouble(),
                      child: Image.memory(LibIma.encodeJpg(imageMostrar),filterQuality: FilterQuality.low,),
                    ),
                    onTapDown: (dato) {
                      if (_editar) {
                        modificar(dato.localPosition.dx.toInt(),
                            dato.localPosition.dy.toInt(), false);
                      }
                      if (_eliminar) {
                        modificar(dato.localPosition.dx.toInt(),
                            dato.localPosition.dy.toInt(), true);
                      }
                    },
                  )),
              circulo(
                  medida,
                  0.15,
                  0.03,
                  Center(
                      child: Text(
                    '${widget.listaPuntos[0].conteo + cambioConteo}',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: medida.maxHeight * 0.05),
                  )),
                  Colors.white,
                  Colors.grey),
              Container(
                height: medida.maxHeight,
                width: medida.maxWidth,
                margin: EdgeInsets.only(
                    top: medida.maxHeight * 0.7, left: medida.maxWidth * 0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: circulo(
                          medida,
                          0.1,
                          0,
                          Center(
                            child: Icon(
                              Icons.add,
                              color: _editar
                                  ? Colors.white
                                  : Theme.of(context).accentColor,
                              size: 15,
                            ),
                          ),
                          _editar
                              ? Theme.of(context).accentColor
                              : Colors.white,
                          Colors.grey),
                      onTap: () {
                        print('cambiar');
                        cambiarEditar(_editar ? false : true);
                      },
                    ),
                    InkWell(
                      child: circulo(
                          medida,
                          0.1,
                          0.03,
                          Center(
                            child: Icon(
                              Icons.remove,
                              size: 15,
                              color: _eliminar
                                  ? Colors.white
                                  : Theme.of(context).accentColor,
                            ),
                          ),
                          _eliminar
                              ? Theme.of(context).accentColor
                              : Colors.white,
                          Colors.grey),
                      onTap: () {
                        print('elimianr');
                        cambiarEliminar(_eliminar ? false : true);
                      },
                    ),
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
/*
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (_eliminar) {
                          widget.enviarEtiquetasEliminadas(
                              etAgregadas, widget.id);
                        }
                        if (_editar) {
                          widget.enviarEtiquetasAnadidas(
                              etEliminadas, widget.id);
                        }
                      },
                    ),*/
