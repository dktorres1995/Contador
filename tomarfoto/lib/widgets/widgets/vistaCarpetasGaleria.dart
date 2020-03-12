import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/ListaFotosGaleria.dart';

class Carpetas extends StatefulWidget {
  final Map<String, List<dynamic>> infoGaleria;
  final Function escogerFoto;
  Carpetas(this.infoGaleria, this.escogerFoto);

  @override
  _CarpetasState createState() => _CarpetasState();
}

class _CarpetasState extends State<Carpetas> {
  bool vistaCarpetas = true;
  bool vistaFotos = false;
  List<dynamic> listaFotosEscogida;
  List<String> titulosCarpetas = List<String>();

  void cambioVista(String vista) {
    setState(() {
      if (vista == 'carpeta') {
        vistaCarpetas = true;
        vistaFotos = false;
      } else if (vista == 'fotos') {
        vistaCarpetas = false;
        vistaFotos = true;
      }
    });
  }

  void cambioListaEscogida(List<dynamic> lista) {
    listaFotosEscogida = lista;
  }

  Widget vistafolder() {
    if(titulosCarpetas.length==0){
    widget.infoGaleria.forEach((key, value) {
      titulosCarpetas.add(key);
    });}
    return SingleChildScrollView(
      child: Column(
        children: titulosCarpetas.map((titulo) {
          return InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(titulo),
            ),
            onTap: () {
              cambioListaEscogida(widget.infoGaleria[titulo]);
              cambioVista('fotos');
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          children: <Widget>[
            InkWell(
              child: Container(
                height: constrains.maxHeight * 0.1,
                width: constrains.maxWidth,
                child: Text(
                  'fotos',
                  style: TextStyle(color: Theme.of(context).accentColor),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                cambioVista('carpeta');
              },
            ),
            Container(
              height: constrains.maxHeight * 0.9,
              width: constrains.maxWidth,
              child: vistaCarpetas
                  ? vistafolder()
                  : vistaFotos
                      ? GrillaFotos(
                          lista: listaFotosEscogida,
                          escogerFoto: widget.escogerFoto,
                        )
                      : null,
            )
          ],
        );
      },
    );
  }
}
