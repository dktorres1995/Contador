import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:tomarfoto/Models/Recursos.dart';
import 'package:tomarfoto/provider/providerConfig.dart';
import 'package:tomarfoto/Models/Conteo.dart';

Future<List<dynamic>> fetchPost(String id) async {
  final response = await http.get('${ConfigPaths.pathServicios}/contar/$id');

  final List<dynamic> lista = [];
  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    lista.add(Recursos.fromJson(json.decode(response.body)));
    final resp =
        await http.get(Recursos.fromJson(json.decode(response.body)).imagenUrl);
    lista.add(resp);
    return lista;
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

Future<Recursos> traerInfoIndividual(String id) async {
  final response = await http.get('${ConfigPaths.pathServicios}/contar/$id');

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    return Recursos.fromJson2(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}

String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
Future<String> ruta() async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Pictures/Dibujo_test';
  await Directory(dirPath).create(recursive: true);

  final String filePath = '$dirPath/${timestamp()}.jpg'; //
  print('crea uno nuevo $filePath' );
  return filePath;
}

Future<List<Recursos>> obtener() async {
  final response = await http.get(ConfigPaths.pathServicios + '/obtenerLista');
  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    final List<dynamic> lista = json.decode(response.body);
    List<Recursos> listaRecursos = [];
    lista.forEach((item) {
      try {
        listaRecursos.add(Recursos.fromJson(item));
      } catch (e) {
        print("no fue posible obtener la url de la imagen");
      }
    });

    return listaRecursos;
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}


Future<http.Response> traerImagen(String url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response;
  } else {
    throw ('errorCode: 200');
  }
}

Future<Map<String, dynamic>> obtenerListaPaginada(String pag) async {
  
  final response = await http
      .get(ConfigPaths.pathServicios + '/ListaPaginada/' + pag + '/todo');
  if (response.statusCode == 200) {
    final List<dynamic> lista = json.decode(response.body)['result'];
    List<RecursoConteo> listaRecursos = [];
    lista.forEach((item) {
      try {
        listaRecursos.add(RecursoConteo.fromJson(item));
      } catch (e) {
        print("no fue posible obtener la url de la imagen");
      }
    });

print('pagina consultada: ${json.decode(response.body)['currPag']}');
    return {
      'lista': listaRecursos,
      'currPag': json.decode(response.body)['currPag'],
      'totalPag':json.decode(response.body)['totalPag']
    };
  } else {
    throw Exception('Failed to load post');
  }
}

Future<dynamic> obtenerListaPaginadatotal() async {
  final response =
      await http.get(ConfigPaths.pathServicios + '/ListaPaginada/1/total');
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}

Future<dynamic> actualizarNombre(String id, String nombreC) async {
    String url = ConfigPaths.pathServicios + '/editarNombre/$id/$nombreC'; 
    final response =
      await http.put(url);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed put');
  }
  }

  Future<dynamic> deshabilitarConteo(String id) async {
    String url = ConfigPaths.pathServicios + '/DesHabilitar/$id'; 
    final response =
      await http.put(url);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed put');
  }
  }
  
Future<dynamic> anadirEtiquetas(List<Map<String, int>> add, String id) async{
 String url= ConfigPaths.pathServicios+"/adicionarEtiquetas/" + id;
 await http.put(
   Uri.encodeFull(url),
   body: json.encode({'lista':add}),
   headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
 );

}

Future<dynamic> eliminarEtiquetas(List<Map<String, int>> elim, String id) async{
 String url= ConfigPaths.pathServicios+"/actEtiquetasEliminadas/" + id;
 await http.put(
   Uri.encodeFull(url),
   body: json.encode({'lista':elim}),
   headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
 );

}


  
