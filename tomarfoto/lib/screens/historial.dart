import 'package:flutter/material.dart';
import 'package:tomarfoto/Models/Recursos.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/TraerInfo.dart';
import 'package:tomarfoto/screens/envioImagen.dart';
import 'package:tomarfoto/screens/envioImagen2.dart';

import 'TraerInfo.dart';

class Historial extends StatefulWidget {
  static const routedName = '/historial';

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  
  void reiniciar(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NUMERATE'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Center(
          child: FutureBuilder(
              future: obtener(),
              builder: (context, AsyncSnapshot<List<Recursos>> snapshot) {
                if (snapshot.hasData) {
                  return crear(snapshot.data, context,reiniciar);
                } else {
                  return CircularProgressIndicator();
                }
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Container(
          child: Icon(
            Icons.camera_alt,
            color: Theme.of(context).accentColor,
          ),
        ),
        onPressed: () =>
            Navigator.of(context).pushNamed(EnvioImagen2.routedName),//Navigator.of(context).pushNamed(EnvioImagen.routedName),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          color: Theme.of(context).accentColor,
          height: 50.0,
        ),
      ),
    );
  }

  Widget crear(List<Recursos> lista, BuildContext ctx,Function reiniciar) {
    return GestureDetector(onLongPress: reiniciar,
          child: ListView.builder(reverse: true,
        itemCount: lista.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: BeveledRectangleBorder(
              side: BorderSide(
                color: Colors.grey,
                width: 0.8,
              ),
            ),
            child: ListTile(
              leading: Image.network(lista[index].imagenUrl,
                  cacheWidth: 70, cacheHeight: 70, fit: BoxFit.fitWidth,filterQuality: FilterQuality.low,),
              title: Text('Varillas conteo ' +
                  (index + 1).toString() +
                  '           ' +
                  '${lista[index].conteo == -1 ? 'Cargando..' : lista[index].conteo.toString()}'),
              onTap: () {
                if (lista[index].conteo == -1 ){

                }else{
               Navigator.of(ctx)
                  .pushNamed(MyApp.routedName, arguments: lista[index].id);}
              }
            ),
          );
        },
      ),
    );
  }
}
