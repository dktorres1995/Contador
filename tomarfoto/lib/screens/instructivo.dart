import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';

class InstructivoScreen extends StatefulWidget {
  static const routedName = '/Instructivo';
  @override
  _InstructivoScrrenState createState() => _InstructivoScrrenState();
}

class _InstructivoScrrenState extends State<InstructivoScreen> {
  @override
  Widget build(BuildContext context) {
    return ContenidoPagina(
        contenido: Center(
          child: Column(
            children: <Widget>[
              swiperInstructivo()
            ],
            
          )
        
        
        
         ),
        titulo: 'Inicio',
        bloqueo: false,confirmacionSalida: false,mensajeConfirmacionSalida: (){});
  }

  Widget swiperInstructivo(){
    
    return Container(
      padding: EdgeInsets.only(top: 50),
      width: 300,
      height: 500,
      child:
    Swiper(
        itemBuilder: (BuildContext context,int index){
          return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
      )
    
    );  
    
  }
}
