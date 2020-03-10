import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tomarfoto/Models/Recursos.dart';
import 'package:tomarfoto/provider/historialprovider.dart';


class Historial extends StatelessWidget {
  static const routedName = '/historial';
  final opciones = ['uno','dos'];
  List<int> _listaNumeros = [1,2,3,4,5];
  @override
   
  Widget build(BuildContext context) {
    

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.lightBlue[900] 
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('NUMERATE'),
          centerTitle: true,
        ),
        body: Center(
           child: FutureBuilder(
            future: obtener(),
            builder: (context, AsyncSnapshot <List<Recursos>> snapshot) {
              
              if (snapshot.hasData){
                 return 


               Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 17.0, 0.0, 0.0),
                  child: crear(snapshot.data),

                );

             
              }else{
              return CircularProgressIndicator();
              }
         
            }

        )
        
        
        
        ),
        
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Container(
           
          child: Icon(Icons.camera_alt,
          color: Theme.of(context).accentColor,
          
          ),
         
        ),
        backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      
      child: Container(
        color: Theme.of(context).accentColor,
        
        height: 50.0,),
    ),
      )
      
    );
    
  }


  Widget crear(List<Recursos> lista){

        return ListView.builder(
          
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index){
          
          return    
 ListTile(leading: Image.network(
   lista[index].imagenUrl,
   width: 100.0,
   height: 50.0,
   
 ),
  title: Text('Varillas conteo ' + (index + 1).toString() + '           ' +lista[index].conteo.toString()));

                    

            
          },

        );
 
  }


}

