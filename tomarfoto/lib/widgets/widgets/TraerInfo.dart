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
  bool _editar = false;
  LibIma.Image imageMostrar;

  void cambiarEditar(bool estado) {
    setState(() {
      _editar = estado;
    });
  }

  void cambiaScalayZoom(double scale, double zoom) {
    _zoom = zoom;
    _scale = scale;
  }

  void cambiaOffset(double x, double y) {
    _offsetX = x;
    _offsetY = y;
  }

  void modificar(int dx, int dy) {
    var xIn =
        ((_offsetX < 0 ? _offsetX * 1.5 : _offsetX) + dx.toDouble() / _scale)
            .round();
    var yIn =
        ((_offsetY < 0 ? _offsetY * 1.7 : _offsetY) + dy.toDouble() / _scale)
            .round();
    print(
        'punto: x$xIn, y$yIn  y tamaño total: yT${imageMostrar.height}, xT${imageMostrar.width}');
    print('escala $_scale zoom:$_zoom');
    setState(() {
      prueba.add({'x': xIn, 'y': yIn});

      imageMostrar = LibIma.drawCircle(imageMostrar, xIn, yIn,
          widget.listaPuntos[0].radio.toInt(), LibIma.getColor(255, 0, 0));
    });
    //print(prueba);
  }

  Widget circulo(BoxConstraints medida, double pH, double pW, double marg,
      Widget contenido, Color colorFondo) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(80)),
      margin: EdgeInsets.all(medida.maxWidth * marg),
      height: medida.maxHeight * pH,
      width: medida.maxWidth * pW,
      padding: EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
            color: colorFondo, borderRadius: BorderRadius.circular(80)),
        child: contenido,
      ),
    );
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
                  height: medida.maxHeight,
                  width: medida.maxWidth,
                  child: Zoom(
                      backgroundColor: Colors.white,
                      initZoom: 0.0,
                      width: imageMostrar.width.toDouble(),
                      height: imageMostrar.height.toDouble(),
                      onPositionUpdate: (Offset position) {
                        print('${position.dx} ' + '${position.dy}');

                        cambiaOffset(position.dx, position.dy);
                      },
                      onScaleUpdate: (double scale, double zoom) {
                        print("escala: $scale y zoom:  $zoom");

                        cambiaScalayZoom(scale, zoom);
                      },
                      child: Center(
                        child: Image.memory(LibIma.encodeJpg(imageMostrar)),
                      )),
                ),
                onTapDown: (dato) {
                  if (_editar) {
                    modificar(dato.localPosition.dx.toInt(),
                        dato.localPosition.dy.toInt());
                  }
                },
                onTapUp: (dato) {
                  if (_editar) {
                    modificar(dato.localPosition.dx.toInt(),
                        dato.localPosition.dy.toInt());
                  }
                },
              ),
              circulo(
                  medida,
                  0.15,
                  0.2,
                  0.03,
                  Center(
                      child: Text(
                    '${widget.listaPuntos[0].conteo}',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: medida.maxHeight * 0.05),
                  )),
                  Colors.white),
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
                          0.15 / 2,
                          0.2 / 2,
                          0,
                          Center(
                            child: Icon(
                              Icons.add,
                              color: _editar
                                  ? Colors.white
                                  : Theme.of(context).accentColor,
                              size: 30,
                            ),
                          ),
                          _editar
                              ? Theme.of(context).accentColor
                              : Colors.white),
                      onTap: () {
                        cambiarEditar(_editar ? false : true);
                      },
                    ),
                    circulo(
                        medida,
                        0.15 / 2,
                        0.2 / 2,
                        0.03,
                        Center(
                          child: Icon(
                            Icons.remove,
                            color: Theme.of(context).accentColor,
                            size: 30,
                          ),
                        ),
                        Colors.white)
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