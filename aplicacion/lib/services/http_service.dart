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

  Future<int?> crearCampeonato(Map<String, dynamic> campeonato) async {
    final url = Uri.parse(
        '$baseURL/campeonatos'); // Asegúrate de que el endpoint sea correcto

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(campeonato),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData[
            'id']; // Asegúrate de que la respuesta contiene la ID del campeonato creado
      } else {
        // Error al crear campeonato
        print('Error al crear campeonato: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error al realizar solicitud: $e');
      return null;
    }
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

  Future<bool> eliminarEquipos(int equipoId) async {
    var url = Uri.parse(
        baseURL + '/equipos/' + equipoId.toString()); // Corregido el endpoint
    var response = await http.delete(url);
    return response.statusCode == 200;
  }

  Future<bool> editarEquipos(Map<String, dynamic> equipo) async {
    var url = Uri.parse(baseURL +
        '/equipos/' +
        equipo['id'].toString()); // Corregido el endpoint
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': equipo['nombre'],
        'entrenador': equipo['entrenador'],
        'juegos_en_donde_participa': equipo['juegos_en_donde_participa'],
      }),
    );
    return response.statusCode == 200;
  }

  Future<bool> crearEquipo(Map<String, dynamic> equipo) async {
    final url = Uri.parse('$baseURL/equipos');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(equipo),
      );

      if (response.statusCode == 201) {
        return true; // Creación exitosa
      } else {
        print('Error al crear equipo: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.body}');
        return false; // Error en la creación
      }
    } catch (e) {
      print('Excepción al crear equipo: $e');
      return false; // Error en la creación
    }
  }

  Future<bool> agregarJugador(Map<String, dynamic> jugador) async {
    var url =
        Uri.parse(baseURL + '/jugadores'); // Endpoint para agregar jugadores
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'rut': jugador['rut'],
        'nombre': jugador['nombre'],
        'apellido': jugador['apellido'],
        'equipo_id':
            jugador['equipo_id'], // ID del equipo al que se agrega el jugador
      }),
    );
    return response.statusCode == 201; // 201 indica que se creó exitosamente
  }

  Future<int?> crearPartidos(Map<String, dynamic> partido) async {
    var url = Uri.parse('$baseURL/partidos');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(partido),
      );

      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['id']; // Devuelve el ID del partido creado
      } else {
        print('Error al crear partido: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.body}');
        return null; // Error en la creación
      }
    } catch (e) {
      print('Excepción al crear partido: $e');
      return null; // Error en la creación
    }
  }

  Future<bool> vincularEquiposAlPartido(
      int partidoId, List<int> equipoIds) async {
    var url = Uri.parse('$baseURL/equipo-partido/vincular');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'partido_id': partidoId,
          'equipo_ids': equipoIds,
        }),
      );

      if (response.statusCode == 200) {
        return true; // Vinculación exitosa
      } else {
        print('Error al vincular equipos al partido: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.body}');
        return false; // Error en la vinculación
      }
    } catch (e) {
      print('Excepción al vincular equipos al partido: $e');
      return false; // Error en la vinculación
    }
  }

  Future<bool> eliminarPartidos(int partidoId) async {
    var url = Uri.parse(baseURL + '/partidos/' + partidoId.toString());
    var response = await http.delete(url);
    return response.statusCode == 200;
  }
}
