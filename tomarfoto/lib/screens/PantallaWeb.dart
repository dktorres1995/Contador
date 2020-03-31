import 'package:flutter/material.dart';
import 'package:tomarfoto/screens/historial.dart';
import 'package:tomarfoto/screens/instructivo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class PantallaWeb extends StatefulWidget {
  static const routedname = "/PantallaWeb";
  @override
  _PantallaWebState createState() => _PantallaWebState();
}

class _PantallaWebState extends State<PantallaWeb> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final String linkAzure =
      "https://numeratead.b2clogin.com/numeratead.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_signupsignin&client_id=ff6a7387-9b63-44d5-8efe-8b4b3857b83d&nonce=defaultNonce&redirect_uri=https%3A%2F%2Flogin.microsoftonline.com%2Ftfp%2Foauth2%2Fnativeclient&scope=openid&response_type=id_token&prompt=login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: linkAzure,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
    
          return NavigationDecision.navigate;
        },
        onPageStarted: (este) {
          if (este.contains(
              'https://login.microsoftonline.com/tfp/oauth2/nativeclient')) {
            var token = este.split('#')[1];
            token = token.split('id_token=')[1]; 
            print('token $token');
            Navigator.of(context).pushNamedAndRemoveUntil(InstructivoScreen.routedName,(ro)=>false);
          }},
      ),
    );
  }
}
