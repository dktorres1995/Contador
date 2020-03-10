import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tomarfoto/Models/Recursos.dart';
import 'package:tomarfoto/provider/historialprovider.dart';
import 'package:tomarfoto/screens/envioImagen.dart';

import 'TraerInfo.dart';


class Historial extends StatelessWidget {
  static const routedName = '/historial';
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


             crear(snapshot.data);
                

             
              }
              
              else{
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
        onPressed:()=> Navigator.of(context).pushNamed(EnvioImagen.routedName) ,
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
          if(lista[index].conteo == 0){
            String prueba = 'Cargando...';   
          }else{
              String prueba = lista[index].conteo.toString();
          }
          return
          InkWell( 
           child: ListTile(leading: Image.network(
              lista[index].imagenUrl,
               width: 100.0,
               height: 50.0,
   
                    ),
                
          title: Text('Varillas conteo ' + (index + 1).toString() + '         ' ),
              ),
  
            onTap: (){
              Future<Recursos> aux=fetchPost();
              Navigator.of(context).pushNamed(MyApp.routedName,arguments: aux);
            }
                  ,
                  
                  
          );
          
          

                    

            
          },

        );
 
  }


}

