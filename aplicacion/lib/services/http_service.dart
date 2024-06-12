import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  // La URL base de la API a la que quieres conectarte
  static const String baseURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> jugadores() async {
    return listarDatos('jugadores');
  }

  Future<List<dynamic>> equipos() async {
    return listarDatos('equipos');
  }

  Future<List<dynamic>> campeonatos() async {
    return listarDatos('campeonatos');
  }

  Future<List<dynamic>> partidos() async {
    return listarDatos('partidos');
  }

  Future<List<dynamic>> resultados() async {
    return listarDatos('resultados');
  }

  Future<List<dynamic>> campeonatoEquipo() async {
    return listarDatos('campeonato_equipo');
  }

  Future<List<dynamic>> equipoPartido() async {
    return listarDatos('equipo_partido');
  }

  Future<List<dynamic>> listarDatos(String coleccion) async {
    var respuesta = await http.get(Uri.parse(baseURL + '/' + coleccion));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    print(respuesta.statusCode);
    return [];
  }
}
