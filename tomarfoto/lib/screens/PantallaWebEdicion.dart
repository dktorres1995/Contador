import 'package:flutter/material.dart';
import '../main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import '../screens/cuenta.dart';
import 'package:corsac_jwt/corsac_jwt.dart';
class PantallaWebEdicion extends StatefulWidget {
  static const routedname = "/PantallaEdicion";
  @override
  _PantallaWebEdicionState createState() => _PantallaWebEdicionState();
}

class _PantallaWebEdicionState extends State<PantallaWebEdicion> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    String link = ModalRoute.of(context).settings.arguments as String;
    
    return LayoutBuilder(
      builder: (context,medida){
        return Scaffold(
      body: Container(
        height: medida.maxHeight,
        width: medida.maxWidth,
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
              PaginaMain.user.setToken(token);
              var decodedToken = new JWT.parse(PaginaMain.user.gettoken());
             PaginaMain.user.completarDatosBasicos(decodedToken.claims);
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
    );
      },
    );
  }
}
