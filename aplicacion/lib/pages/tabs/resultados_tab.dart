import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultadosTab extends StatefulWidget {
  const ResultadosTab({Key? key}) : super(key: key);

  @override
  _ResultadosTabState createState() => _ResultadosTabState();
}

class _ResultadosTabState extends State<ResultadosTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_equipo.jpg');
  final HttpService httpService = HttpService();
  List<dynamic> resultados = [];
  List<dynamic> equipos = [];

  late Future<void> _cargarResultadosFuture;

  @override
  void initState() {
    super.initState();
    _cargarResultadosFuture = cargarResultados();
  }

  Future<void> cargarResultados() async {
    try {
      List<dynamic> listaResultados = await httpService.resultados();
      List<dynamic> listaEquipos = await httpService.equipos();
      setState(() {
        resultados = listaResultados;
        equipos = listaEquipos;
      });
    } catch (e) {
      print('Error al cargar resultados o equipos: $e');
    }
  }

  String obtenerNombreEquipo(int id) {
    final equipo = equipos.firstWhere((equipo) => equipo['id'] == id, orElse: () => null);
    return equipo != null ? equipo['nombre'] : 'Desconocido';
  }

  @override
  Widget build(BuildContext context) {
    // Estilos para texto
    TextStyle estilo_nombre = GoogleFonts.oswald(
      textStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
    TextStyle estilo_seccion = GoogleFonts.oswald(
      textStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
    TextStyle estilo_dato = GoogleFonts.oswald(
      textStyle: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
    );

    return Scaffold(
      body: FutureBuilder<void>(
        future: _cargarResultadosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.black,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar datos: ${snapshot.error}'));
          } else {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: fondo, fit: BoxFit.cover),
              ),
              child: ListView.builder(
                itemCount: resultados.length,
                itemBuilder: (context, index) {
                  final resultado = resultados[index];
                  final nombreGanador = obtenerNombreEquipo(resultado['equipo_ganador_id']);
                  final nombrePerdedor = obtenerNombreEquipo(resultado['equipo_perdedor_id']);

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/resultado_icono.png'),
                        backgroundColor: Colors.black,
                      ),
                      title: Text(
                        '🏆 Ganador: $nombreGanador',
                        style: estilo_seccion,
                      ),
                      subtitle: Text(
                        '❌ Perdedor: $nombrePerdedor',
                        style: estilo_seccion,
                      ),
                      onTap: () {
                        // Acciones al hacer tap en un resultado si es necesario
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
