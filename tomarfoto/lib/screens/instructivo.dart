import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../main.dart';
import '../widgets/widgets/Plantilla.dart';
import 'package:corsac_jwt/corsac_jwt.dart';
class InstructivoScreen extends StatefulWidget {
  static const routedName = '/Instructivo';
  @override
  _InstructivoScrrenState createState() => _InstructivoScrrenState();
}

class _InstructivoScrrenState extends State<InstructivoScreen> {
  @override
  Widget build(BuildContext context) {

  var decodedToken = new JWT.parse(PaginaMain.user.gettoken());
  PaginaMain.user.completarDatosBasicos(decodedToken.claims);

  //print(decodedToken.verify(signer)); 
    return LayoutBuilder(
      builder: (context, medida) {
        return ContenidoPagina(
            contenido: Padding(
                padding: EdgeInsets.only(bottom: medida.maxHeight * 0.07),
                child: Center(child: swiperInstructivo(medida))),
            titulo: 'Inicio',
            bloqueo: false,
            confirmacionSalida: false,
            mensajeConfirmacionSalida: () {});
      },
    );
  }

  Widget swiperInstructivo(BoxConstraints medida) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Card(
            margin: EdgeInsets.symmetric(
                horizontal: medida.maxHeight * 0.07,
                vertical: medida.maxWidth * 0.15),
            elevation: 20,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Image.asset(
              'assets/images/${index + 1}.png',
              fit: BoxFit.fill,
            ));
      },
      itemCount: 3,
      pagination: SwiperPagination(),
    );
  }
}
