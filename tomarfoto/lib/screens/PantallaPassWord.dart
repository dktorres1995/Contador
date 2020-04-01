import 'package:flutter/material.dart';
import 'package:tomarfoto/main.dart';
import 'package:tomarfoto/screens/PantallaWeb.dart';
import 'package:tomarfoto/screens/instructivo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class PantallaPassword extends StatefulWidget {
  static const routedname = "/PantallaPassword";
  @override
  _PantallaWebState createState() => _PantallaWebState();
}

class _PantallaWebState extends State<PantallaPassword> {
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
          print(este);
          if (este.contains(
              'https://login.microsoftonline.com/tfp/oauth2/nativeclient#error=access_denied&error_description=AADB2C90118')) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(PantallaWeb.routedname, (ro) => false,arguments: PaginaMain.linkRecoveryPassword);
          }
        },
      ),
    );
  }
}
