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
  final HttpService httpService = HttpService();
  List<dynamic> partidos = [];
  List<dynamic> equipos = [];
  List<dynamic> equipoPartido = [];

  late Future<void> _cargarPartidosFuture;

  @override
  void initState() {
    super.initState();
    _cargarPartidosFuture = cargarPartidos();
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
        child: FutureBuilder<void>(
          future: _cargarPartidosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: Colors.red));
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error al cargar datos: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: partidos.length,
                itemBuilder: (context, index) {
                  final partido = partidos[index];
                  final nombresEquipos = obtenerNombresEquipos(partido['id']);

                  if (nombresEquipos.isNotEmpty) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                    return SizedBox.shrink();
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
