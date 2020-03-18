import 'dart:io';
import 'package:image/image.dart' as LibIma;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/envioImagen.dart';

class MyApp extends StatefulWidget {
  static const routedName = '/TraerInfo';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
List<Map<String,int>> prueba = List<Map<String,int>>();

 void modificar(int dx, int dy){

    setState(() {
     prueba.add({'x': dx,'y': dy}); 
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    modificar(200,300);
    return Scaffold(
      appBar: AppBar(
        title: Text('NUMERATE'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchPost(id),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
               var image3 =
                LibIma.decodeJpg((snapshot.data[1] as http.Response).bodyBytes);
              print('${image3.width} ancho' + '${image3.height} largo');
            for (var coordenada in snapshot.data[0].centros) {
              
              image3 = LibIma.drawCircle(image3, coordenada['x'], coordenada['y'], snapshot.data[0].radio.toInt(),
              LibIma.getColor(0, 255, 255)); 
             }        

              image3 = LibIma.drawCircle(image3, 1588, 906, snapshot.data[0].radio.toInt(),
              LibIma.getColor(255, 255, 255));
         if(prueba.isNotEmpty)  {
          for(var coord in prueba){
            image3 = LibIma.drawCircle(image3, coord['x'], coord['y'], snapshot.data[0].radio.toInt(),
              LibIma.getColor(255, 0, 0));             
          }}

        return FutureBuilder(
           future: ruta(),
           builder: (context, info) {
              if (info.hasData) {
              File(info.data ).writeAsBytesSync(LibIma.encodeJpg(image3));
              return SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                   GestureDetector(child:
                   Container(child: PhotoViewGestureDetectorScope(
                  child: PhotoView(
                        //basePosition: Alignment.topLeft,
                        imageProvider: AssetImage(File(info.data).path),
                         
                         
                   ),                                
                   ),
                    height: 800.0, 
                   width: 800.0,
                   ),
                   onTapUp: (info) {        
                   
                    print('${info.globalPosition.dy} en y' + '${info.globalPosition.dx} en x');
                    
                     modificar((info.localPosition.dx).toInt(),(info.localPosition.dy).toInt());
                      }
                    ),
                    ClipOval(
                        child: Container(
                            color: Colors.grey.withOpacity(0.9),
                            height: 50.0, // height of the button
                            width: 50.0,
                            child: Align(
                              child: Center(
                                  child: Text('${snapshot.data[0].conteo}')),
                            ))),                     
                  ],
                ),
              );}

                return CircularProgressIndicator(
              backgroundColor: Colors.green,
            );
              }
             
              );
            } else if (snapshot.hasError) {
              return CircularProgressIndicator();
            }

            // Por defecto, muestra un loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(EnvioImagen.routedName),
        child: Container(
          child: Icon(
            Icons.camera_alt,
            color: Theme.of(context).accentColor,
          ),
        ),
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
}
