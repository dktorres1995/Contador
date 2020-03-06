import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tomarfoto/Models/Recursos.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';



class MyApp extends StatelessWidget {
  static const routedName = '/TraerInfo';
  @override
  Widget build(BuildContext context) {
    
  final Future<Recursos> post=ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'NUMERATE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.lightBlue[900] 
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('NUMERATE'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                      icon: Icon(Icons.home),
                        onPressed: () {
                       
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) =>  PantallaInicial()) );
                        },
                      )
          ],
           
        ),
        body: Center(
          child: FutureBuilder<Recursos>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                 
                  
                  children: <Widget>[
                    ClipOval(
                      child: Container(
                        color: Colors.white.withOpacity(0.9),
                        height: 120.0, // height of the button
                        width: 120.0,
                        child: Align(
                          
                        
                        child: Center(child: Text('${snapshot.data.conteo}')),
                        )
                          
                          // height of the button
                         
                          
                      )
            
                    ),
                    Image.network(snapshot.data.imagenUrl),
                   
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // Por defecto, muestra un loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Container(
           
          child: Icon(Icons.camera_alt,
          color: Theme.of(context).accentColor,
          
          )
        )
        ),
        bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      
      child: Container(
        color: Theme.of(context).accentColor,
        
        height: 50.0,),
    ),
      ),
    );
  }
}