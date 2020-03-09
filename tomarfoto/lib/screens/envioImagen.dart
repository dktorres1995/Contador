import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/TomaFoto.dart';

class EnvioImagen extends StatefulWidget {
   static const routedName ="/pantallaInicialEnvioImagen";
  @override
  _EnvioImagenState createState() => _EnvioImagenState();
}

class _EnvioImagenState extends State<EnvioImagen> {
  
  @override
  Widget build(BuildContext context) {
    return 
Scaffold(
      appBar: AppBar(
        title: const Text('Toma de foto'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: pantallaInicialEnvios(),
    ) ;

  }
}
 

Widget pantallaInicialEnvios(){

return LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: constrains.maxHeight * 0.9,
                width: constrains.maxWidth,
                child: Center(
                  child: CameraExampleHome(),
                ),
              ),
            ),
            Container(
                height: constrains.maxHeight * 0.1,
                width: constrains.maxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).accentColor,
                      width: constrains.maxWidth * 0.5,
                      height: constrains.maxHeight * 0.1,
                      padding:
                          EdgeInsets.only(top: constrains.maxHeight * 0.04),
                      child: SafeArea(
                        child: Text(
                          'Galería',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Container(
                      color: Theme.of(context).accentColor,
                      width: constrains.maxWidth * 0.5,
                      height: constrains.maxHeight * 0.1,
                      padding:
                          EdgeInsets.only(top: constrains.maxHeight * 0.04),
                      child: SafeArea(
                        child: Text(
                          'Foto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        );
      },
    );

}