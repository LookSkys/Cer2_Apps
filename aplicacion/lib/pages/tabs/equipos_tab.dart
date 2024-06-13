import 'package:aplicacion/pages/tabs/editar_equipo.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion/pages/tabs/equipo_detalles.dart';
import 'package:aplicacion/services/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

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

  late Future<void> _cargarEquiposFuture;

  @override
  void initState() {
    super.initState();
    _cargarEquiposFuture = cargarEquipos();
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

  Future<void> eliminarEquipo(int equipoId) async {
    try {
      bool eliminado = await httpService.eliminarEquipos(equipoId);
      if (eliminado) {
        setState(() {
          equipos.removeWhere((equipo) => equipo['id'] == equipoId);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Equipo eliminado correctamente'),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al eliminar equipo'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print('Error al eliminar equipo: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al eliminar equipo'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Estilos para texto
    TextStyle estiloSeccion = GoogleFonts.oswald(
      textStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
    TextStyle estiloDato = GoogleFonts.oswald(
      textStyle: TextStyle(fontSize: 17, color: Colors.white),
    );

    return Scaffold(
      body: FutureBuilder<void>(
        future: _cargarEquiposFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: fondo, fit: BoxFit.cover),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.teal, // Cambia el color aquí
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error al cargar datos: ${snapshot.error}'));
          } else {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: fondo, fit: BoxFit.cover),
              ),
              child: ListView.builder(
                itemCount: equipos.length,
                itemBuilder: (context, index) {
                  final equipo = equipos[index];
                  final nombresJugadores =
                      obtenerNombresJugadores(equipo['id']);

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
                            AssetImage('assets/images/equipo_icono.png'),
                        backgroundColor: Colors.black,
                      ),
                      title: Text(
                        '💠 ${equipo['nombre']}',
                        style: estiloSeccion,
                      ),
                      subtitle: Text(
                        'Entrenador: ${equipo['entrenador']}',
                        style: estiloDato,
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditarEquipo(
                                    equipo: equipo,
                                    equipoId: equipo['id'],
                                  ),
                                ),
                              ).then((value) {
                                if (value == true) {
                                  cargarEquipos();
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirmación'),
                                    content: Text(
                                        '¿Estás seguro de querer eliminar este equipo?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancelar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Aceptar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          eliminarEquipo(equipo['id']);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
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
