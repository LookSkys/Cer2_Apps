import 'package:flutter/material.dart';
import 'package:aplicacion/pages/tabs/partido_detalles.dart';
import 'package:aplicacion/services/http_service.dart';

class CalendarioTab extends StatefulWidget {
  const CalendarioTab({Key? key}) : super(key: key);

  @override
  _CalendarioTabState createState() => _CalendarioTabState();
}

class _CalendarioTabState extends State<CalendarioTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_equipo.jpg');
  final HttpService httpService = HttpService(); // Instancia de tu HttpService
  List<dynamic> partidos = [];
  List<dynamic> equipos = [];
  List<dynamic> equipoPartido = [];

  @override
  void initState() {
    super.initState();
    cargarPartidos(); // Cargar partidos al inicializar la página
  }

  Future<void> cargarPartidos() async {
    try {
      List<dynamic> listaPartidos = await httpService.partidos();
      List<dynamic> listaEquipos = await httpService.equipos();
      List<dynamic> listaEquipoPartido = await httpService.equipoPartido();
      setState(() {
        partidos = listaPartidos;
        equipos = listaEquipos;
        equipoPartido = listaEquipoPartido;
      });
    } catch (e) {
      print('Error al cargar partidos: $e');
    }
  }

  List<String> obtenerNombresEquipos(int partidoId) {
    List<int> idsEquipos = equipoPartido
        .where((ep) => ep['partido_id'] == partidoId)
        .map<int>((ep) => ep['equipo_id'])
        .toList();

    // Filtrar los equipos que existen
    List<String> nombresEquipos = equipos
        .where((equipo) => idsEquipos.contains(equipo['id']))
        .map<String>((equipo) => equipo['nombre'])
        .toList();

    return nombresEquipos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit: BoxFit.cover),
        ),
        child: ListView.builder(
          itemCount: partidos.length,
          itemBuilder: (context, index) {
            final partido = partidos[index];
            final nombresEquipos = obtenerNombresEquipos(partido['id']);

            // Mostrar solo los partidos que tienen equipos asociados
            if (nombresEquipos.isNotEmpty) {
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
                    backgroundImage:
                        AssetImage('assets/images/partido_icono.png'),
                    backgroundColor: Colors.black,
                  ),
                  title: Text(
                    '💠 ${partido['fecha']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Lugar: ${partido['lugar']}',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PartidoDetalles(
                          partido: partido,
                          nombresEquipos: nombresEquipos,
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return SizedBox
                  .shrink(); // No mostrar el ListTile si no hay equipos
            }
          },
        ),
      ),
    );
  }
}
