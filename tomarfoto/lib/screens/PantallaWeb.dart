import 'package:flutter/material.dart';
import 'package:tomarfoto/main.dart';
import 'package:tomarfoto/screens/instructivo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:tomarfoto/screens/PantallaPassWord.dart';

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
          print('Link Actual:::==> $este');
          if (este.contains(
              'https://login.microsoftonline.com/tfp/oauth2/nativeclient#id_token=')) {
            var token = este.split('#id_token=')[1];
            //print('token $token');
            //print('----------');
            PaginaMain.user.setToken(token);
            Navigator.of(context).pushNamedAndRemoveUntil(
                InstructivoScreen.routedName, (ro) => false);
          } else if (este.contains(
              'https://login.microsoftonline.com/tfp/oauth2/nativeclient#error=access_denied&error_description=AADB2C90091')) {
           print('volvio al login desde el formulario');
            Navigator.of(context)
                .pushNamedAndRemoveUntil(PantallaPassword.routedname, (ro) => false,arguments: PaginaMain.linkAzure);
          } else if (este.contains(
              'https://login.microsoftonline.com/tfp/oauth2/nativeclient#error=access_denied&error_description=AADB2C90118')) {
           print('volvio al login desde password');
           Navigator.of(context)
                .pushNamedAndRemoveUntil(PantallaPassword.routedname, (ro) => false,arguments: PaginaMain.linkRecoveryPassword);
          }

        },
      ),
    );
  }
}
