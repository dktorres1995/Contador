import 'package:flutter/material.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/TraerInfo.dart';

class ItemHistorial extends StatelessWidget {
  final String idImag;
  final String urlImag;

  ItemHistorial(this.idImag, this.urlImag);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: traerInfoIndividual(idImag),
      builder: (context, elemento) {
        if (elemento.hasData) {
          return ListTile(
              leading: Image.network(
                urlImag,
                cacheWidth: 70,
                cacheHeight: 70,
                fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.low,
              ),
              title: Text('Varillas conteo '
                      '           ' +
                  '${elemento.data.conteo == -1 ? 'Cargando..' : elemento.data.conteo.toString()}'),
              onTap: () {
                if (elemento.data.conteo != -1)
                  Navigator.of(context)
                      .pushNamed(MyApp.routedName, arguments: elemento.data.id);
              });
        } else if (elemento.hasError) {}
        return Container();
      },
    );
  }
}
