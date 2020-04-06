import 'package:flutter/material.dart';
import '../main.dart';
import '../provider/providerConfig.dart';
import '../screens/instructivo.dart';
import '../screens/pantallaInicial.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import '../screens/PantallaWebAux.dart';

class PantallaWeb extends StatefulWidget {
  static const routedname = "/PantallaWeb";
  @override
  _PantallaWebState createState() => _PantallaWebState();
}

class _PantallaWebState extends State<PantallaWeb> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    String link = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: WebView(
        initialUrl: link, //'www.google.com',//
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
        onPageStarted: (este) {
          //print('Link Actual:::==> $este');
          if (este.contains(
              'https://login.microsoftonline.com/tfp/oauth2/nativeclient#id_token=' )) {
            var token = este.split('#id_token=')[1];
            //print('token $token');
            //print('----------');
            PaginaMain.user.setToken(token);
            Navigator.of(context).pushNamedAndRemoveUntil(
                InstructivoScreen.routedName, (ro) => false);
          } else if (este.contains(
              'https://login.microsoftonline.com/tfp/oauth2/nativeclient#error=access_denied&error_description=AADB2C90091')) {
           
            Navigator.of(context)
                .pushNamedAndRemoveUntil(PantallaWebAux.routedname, (ro) => false,arguments: ConfigPaths.linkAzure);
          } else if (este.contains(
              'https://login.microsoftonline.com/tfp/oauth2/nativeclient#error=access_denied&error_description=AADB2C90118')) {
           
           Navigator.of(context)
                .pushNamedAndRemoveUntil(PantallaWebAux.routedname, (ro) => false,arguments: ConfigPaths.linkRecoveryPassword);
          }else if(este.contains('https://login.microsoftonline.com/9055e649-2fe3-410b-8429-148821f353d2/oauth2/logout?client_id=ff6a7387-9b63-44d5-8efe-8b4b3857b83d')){
            
           Navigator.of(context)
                .pushNamedAndRemoveUntil(PantallaInicial.routedName, (ro) => false);
          
          }

        },
      ),
    );
  }
}
