import 'package:flutter/material.dart';
import 'package:tomarfoto/main.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: constrains.maxHeight * 0.2,
              width: constrains.maxWidth * 0.2,
              child: FloatingActionButton(
                onPressed: () {},
                elevation: 20,
                child: Text(
                  PaginaMain.user.getnombre().substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      fontSize: constrains.maxWidth * 0.1,
                      color: Theme.of(context).accentColor),
                ),
                backgroundColor: Colors.white,
              ),
            ),
            Text(
              PaginaMain.user.getnombre(),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              PaginaMain.user.getcorreo(),
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey),
            ),
            Padding(padding: EdgeInsets.only(top:constrains.maxHeight*0.03),),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.edit,
                    size: constrains.maxHeight * 0.03,
                    color: Theme.of(context).accentColor,
                  ),
                  InkWell(
                      child: Text(
                        'Editar perfil',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      onTap: () {
                        //editar
                      }),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top:constrains.maxHeight*0.03),),
            Container(
              child: InkWell(
                  child: Text(
                    'Cerrar sesión',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    //cerrar sesion
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(top: constrains.maxHeight * 0.44),
            ),
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
                  _ejecutarCorreo('atencionAlCliente@numeratead.onmicrosoft.com',
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
