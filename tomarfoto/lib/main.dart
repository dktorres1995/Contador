import 'package:flutter/material.dart';
import 'package:Numerate/Models/usuarioDatos.dart';
import 'package:Numerate/routes/routes.dart';
import 'package:Numerate/screens/pantallaInicial.dart';
import 'package:Numerate/mixis/mixis_block_screen.dart';

void main() => runApp(PaginaMain());

class PaginaMain extends StatelessWidget with PortraitModeMixin {
  static Usuario user = Usuario('');
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
/* keytool -genkey -dname "cn=CompanyName, ou=OrgUnit, o=OrgName, c=US" -alias asesoftware -keypass admin123 -keystore android.keystore -storepass admin123 -validity 10000 -keyalg RSA -keysize 2048 */