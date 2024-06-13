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

  Future<bool> eliminarCampeonato(int campeonatoId) async {
    var url = Uri.parse(baseURL + '/campeonatos/' + campeonatoId.toString());
    var response = await http.delete(url);
    return response.statusCode == 200;
  }

  Future<bool> editarCampeonato(Map<String, dynamic> campeonato) async {
    var url =
        Uri.parse(baseURL + '/campeonatos/' + campeonato['id'].toString());
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': campeonato['nombre'],
        'fecha_inicio': campeonato['fecha_inicio'],
        'fecha_fin': campeonato['fecha_fin'],
        'reglas': campeonato['reglas'],
        'premios': campeonato['premios'],
      }),
    );
    return response.statusCode == 200;
  }

  Future<bool> vincularEquipo(int campeonatoId, int equipoId) async {
    final response = await http.post(
      Uri.parse('$baseURL/campeonatos/$campeonatoId/equipos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'equipo_id': equipoId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
