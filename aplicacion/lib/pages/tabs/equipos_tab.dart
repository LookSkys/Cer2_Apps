import 'package:flutter/material.dart';
import 'package:aplicacion/pages/tabs/equipo_detalles.dart';
import 'package:aplicacion/services/http_service.dart';

class EquiposTab extends StatefulWidget {
  const EquiposTab({Key? key}) : super(key: key);

  @override
  _EquiposTabState createState() => _EquiposTabState();
}

class _EquiposTabState extends State<EquiposTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_equipo.jpg');
  final HttpService httpService = HttpService();
  List<dynamic> equipos = [];
  List<dynamic> jugadores = [];

  @override
  void initState() {
    super.initState();
    cargarEquipos();
  }

  Future<void> cargarEquipos() async {
    try {
      List<dynamic> listaEquipos = await httpService.equipos();
      List<dynamic> listaJugadores = await httpService.jugadores();
      setState(() {
        equipos = listaEquipos;
        jugadores = listaJugadores;
      });
    } catch (e) {
      print('Error al cargar equipos: $e');
    }
  }

  List<String> obtenerNombresJugadores(int equipoID) {
    List<String> idsJugadores = jugadores
        .where((jugador) => jugador['equipo_id'] == equipoID)
        .map<String>((jugador) => jugador['rut'])
        .toList();

    List<String> nombresJugadores = jugadores
        .where((jugador) => idsJugadores.contains(jugador['rut']))
        .map<String>((jugador) => jugador['nombre'] + ' ' + jugador['apellido'])
        .toList();

    return nombresJugadores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit: BoxFit.cover),
        ),
        child: ListView.builder(
          itemCount: equipos.length,
          itemBuilder: (context, index) {
            final equipo = equipos[index];
            final nombresJugadores = obtenerNombresJugadores(equipo['id']);

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
                  backgroundImage: AssetImage('assets/images/equipo_icono.png'),
                  backgroundColor: Colors.black,
                ),
                title: Text(
                  '💠 ${equipo['nombre']}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  'Entrenador: ${equipo['entrenador']}',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EquipoDetalles(
                        equipo: equipo,
                        jugadores: nombresJugadores,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
