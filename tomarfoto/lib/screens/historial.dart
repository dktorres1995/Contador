import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tomarfoto/Models/Recursos.dart';


class Historial extends StatelessWidget {
  static const routedName = '/historial';
  final opciones = ['uno','dos'];
  List<int> _listaNumeros = [1,2,3,4,5];
  @override
   
  Widget build(BuildContext context) {
    final Future<Recursos> post=ModalRoute.of(context).settings.arguments;
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
        body: crear(),
        
        
        
        
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


  Widget crear(){

        return ListView.builder(
          itemCount: _listaNumeros.length,
          itemBuilder: (BuildContext context, int index){
            final imagen = _listaNumeros[index];
            Divider();
            return FadeInImage(
              image: NetworkImage('https://i.picsum.photos/id/$imagen/50/30.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),

            );
            

          },

        );
 
  }


}

