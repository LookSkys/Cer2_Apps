import 'package:aplicacion/pages/tabs/agregar_partidos.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion/pages/tabs/partido_detalles.dart';
import 'package:aplicacion/services/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

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
    //Estilos para texto
    TextStyle estilo_seccion = GoogleFonts.oswald(
        textStyle: TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white));
    TextStyle estilo_dato = GoogleFonts.oswald(
        textStyle: TextStyle(fontSize: 17, color: Colors.white));

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
                child: CircularProgressIndicator(color: Colors.red),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error al cargar datos: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: partidos.length,
                itemBuilder: (context, index) {
                  final partido = partidos[index];
                  final nombresEquipos = obtenerNombresEquipos(partido['id']);

                  // Verificar si el partido tiene al menos dos equipos asignados
                  if (nombresEquipos.length >= 2) {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/partido_icono.png'),
                              backgroundColor: Colors.black,
                            ),
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        nombresEquipos[0],
                                        style: estilo_seccion,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/versus_icono.png', // Ruta de la imagen
                                      width: 50, // Ancho de la imagen
                                      height: 50, // Alto de la imagen
                                    ),
                                    Expanded(
                                      child: Text(
                                        nombresEquipos[1],
                                        style: estilo_seccion,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Fecha: ${partido['fecha']}',
                                style: estilo_dato,
                                textAlign: TextAlign.center,
                              ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  // Acción para editar el partido
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Acción para eliminar el partido
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Si no hay suficientes equipos, o el partido no tiene equipos asignados, se muestra un SizedBox.shrink()
                    return SizedBox.shrink();
                  }
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega a la página deseada cuando se presione el botón
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CrearPartido(), // Reemplaza con la página deseada
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
