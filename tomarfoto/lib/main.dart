import 'package:flutter/material.dart';
import 'package:tomarfoto/Models/usuarioDatos.dart';
import 'package:tomarfoto/routes/routes.dart';
import 'package:tomarfoto/screens/pantallaInicial.dart';
import 'package:tomarfoto/mixis/mixis_block_screen.dart';

void main() => runApp(PaginaMain());

class PaginaMain extends StatelessWidget with PortraitModeMixin {
  static Usuario user = Usuario('');
  static String linkAzure =
      "https://numeratead.b2clogin.com/numeratead.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_signupsignin&client_id=ff6a7387-9b63-44d5-8efe-8b4b3857b83d&nonce=defaultNonce&redirect_uri=https%3A%2F%2Flogin.microsoftonline.com%2Ftfp%2Foauth2%2Fnativeclient&scope=openid&response_type=id_token&prompt=login";
  static String linkRecoveryPassword =
      "https://numeratead.b2clogin.com/numeratead.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_passwordreset&client_id=ff6a7387-9b63-44d5-8efe-8b4b3857b83d&nonce=defaultNonce&redirect_uri=https%3A%2F%2Flogin.microsoftonline.com%2Ftfp%2Foauth2%2Fnativeclient&scope=openid&response_type=id_token&prompt=login";
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ConteoAppV1',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.indigo[900],
        ), //CameraExampleHome(cameras),
        routes: getAplicaciones(),
        initialRoute: PantallaInicial.routedName,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => PantallaInicial());
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => PantallaInicial());
        });
  }
}
