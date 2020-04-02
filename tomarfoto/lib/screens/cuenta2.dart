import 'package:flutter/material.dart';
import 'package:tomarfoto/main.dart';
import 'package:tomarfoto/widgets/widgets/Plantilla.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:tomarfoto/screens/cuenta.dart';

class CuentaScreen2 extends StatefulWidget {
  static const routedName = "/cuentaScreen2";
  @override
  _CuentaScreenState createState() => _CuentaScreenState();
}

class _CuentaScreenState extends State<CuentaScreen2> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    String link = ModalRoute.of(context).settings.arguments as String;
    return ContenidoPagina(
      contenido: LayoutBuilder(builder: (context, constrains) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: constrains.maxHeight * 0.2,
              width: constrains.maxWidth * 0.2,
              child: FloatingActionButton(
                heroTag: 'cuenta',
                onPressed: () {},
                child: Text(
                  PaginaMain.user.getnombre().substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      fontSize: constrains.maxWidth * 0.1,
                      color: Theme.of(context).accentColor),
                ),
                backgroundColor: Colors.white,
              ),
            ),Container(
              height: constrains.maxHeight*0.8,
              width: constrains.maxWidth,
        child: WebView(
          initialUrl: link, 
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onPageStarted: (este) {
            print('Pantalla Edicion::=>$este');
            if (este.contains(
                'https://login.microsoftonline.com/tfp/oauth2/nativeclient#id_token=')) {
              var token = este.split('#id_token=')[1];
              //print('token $token');
              //print('----------');
              PaginaMain.user.setToken(token);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  CuentaScreen.routedName, (ro) => false);
            } else if (este.contains(
                'https://login.microsoftonline.com/tfp/oauth2/nativeclient#error=access_denied&error_description=AADB2C90091')) {
             
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(CuentaScreen.routedName, (ro) => false);
            }
          },
        ),
      ),
          ],
        );
      }),
      titulo: 'Cuenta',
      bloqueo: false,
      confirmacionSalida: false,
      mensajeConfirmacionSalida: () {},
    );
  }

}
