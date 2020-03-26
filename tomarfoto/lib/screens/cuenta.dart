import 'package:flutter/material.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';
import 'package:url_launcher/url_launcher.dart';

class CuentaScreen extends StatefulWidget {
  static const routedName = "/cuentaScreen";
  @override
  _CuentaScreenState createState() => _CuentaScreenState();
}

class _CuentaScreenState extends State<CuentaScreen> {
  @override
  Widget build(BuildContext context) {
    return ContenidoPagina(
      contenido: LayoutBuilder(builder: (context, constrains) {
        return Column(
          children: <Widget>[
            CircleAvatar(
              child: Text('S',
              style: TextStyle(fontSize: constrains.maxWidth *0.1),
              ),
              radius: constrains.maxWidth*0.1,
            ),
            Text(
              'Nombre usuario',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'nombreusuario@gmail.com',
              textAlign: TextAlign.right,
              style: TextStyle(
              color: Colors.grey
              ),
            ),
            InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.edit),
                    Text(
                      'Editar perfil',
                      style: TextStyle(
                        color: Colors.blue
                      ),
                    )
                  ],
                ),
                onTap: () {
                 //editar
                }),
                InkWell(
      
                   child: Text(
                      'Cerrar sesión',
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ),
                
                onTap: () {
                 //cerrar sesion
                }),

            Text(
              '¿Necesitas ayuda?',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.blueAccent),
            ),
            Divider(),
            InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.headset_mic),
                    Text(
                      'Contactar',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  _ejecutarCorreo('dtorres@asesoftware.com',
                      'Dudas e inquietudes', 'prueba');
                }),
          ],
        );
      }),
      titulo: 'Cuenta',
      bloqueo: false,
      confirmacionSalida: false,
      mensajeConfirmacionSalida: () {},
    );
  }

  _ejecutarCorreo(String toMailId, String subject, String body) {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    launch(url);
  }
}
