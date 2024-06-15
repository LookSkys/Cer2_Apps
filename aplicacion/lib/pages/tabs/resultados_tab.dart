import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplicacion/pages/tabs/agregar_resultados.dart';

class ResultadosTab extends StatefulWidget {
  const ResultadosTab({Key? key}) : super(key: key);

  @override
  _ResultadosTabState createState() => _ResultadosTabState();
}

class _ResultadosTabState extends State<ResultadosTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_resultados.jpg');
  final HttpService httpService = HttpService();
  List<dynamic> resultados = [];
  List<dynamic> equipos = [];
  List<dynamic> campeonatos = [];
  List<dynamic> partidos = [];

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
      List<dynamic> listaCampeonatos = await httpService.campeonatos();
      List<dynamic> listaPartidos = await httpService.partidos();
      setState(() {
        resultados = listaResultados;
        equipos = listaEquipos;
        campeonatos = listaCampeonatos;
        partidos = listaPartidos;
      });
    } catch (e) {
      print('Error al cargar resultados, equipos, campeonatos o partidos: $e');
    }
  }

  String obtenerNombreEquipo(int? id) {
    if (id == null) {
      return 'Desconocido';
    }
    final equipo =
        equipos.firstWhere((equipo) => equipo['id'] == id, orElse: () => null);
    return equipo != null ? equipo['nombre'] : 'Desconocido';
  }

  String obtenerNombreCampeonato(int? partidoId) {
    if (partidoId == null) {
      return 'Desconocido';
    }

    // Buscar el partido por partidoId
    final partido = partidos.firstWhere(
      (partido) => partido['id'] == partidoId,
      orElse: () => null,
    );

    if (partido == null) {
      return 'Desconocido';
    }

    // Obtener el campeonato por id_campeonato
    final idCampeonato = partido['campeonato_id'];
    final campeonato = campeonatos.firstWhere(
      (campeonato) => campeonato['id'] == idCampeonato,
      orElse: () => null,
    );

    if (campeonato == null) {
      return 'Desconocido';
    }

    return campeonato['nombre'] ?? 'Desconocido';
  }

  Future<void> eliminarResultado(int resultadoId) async {
    try {
      bool eliminado = await httpService.eliminarResultados(resultadoId);
      if (eliminado) {
        setState(() {
          resultados.removeWhere((resultado) => resultado['id'] == resultadoId);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Resultado eliminado correctamente'),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al eliminar resultado'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print('Error al eliminar resultado: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al eliminar resultado'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Estilos para texto
    TextStyle estilo_seccion = GoogleFonts.oswald(
      textStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
    TextStyle estilo_dato = GoogleFonts.oswald(
      textStyle: TextStyle(fontSize: 17, color: Colors.white),
    );
    return Scaffold(
      body: FutureBuilder<void>(
        future: _cargarResultadosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: fondo, fit: BoxFit.cover),
              ),
              child: Center(child: CircularProgressIndicator()),
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
                itemCount: resultados.length,
                itemBuilder: (context, index) {
                  final resultado = resultados[index];
                  final nombreGanador =
                      obtenerNombreEquipo(resultado['equipo_ganador_id']);
                  final nombrePerdedor =
                      obtenerNombreEquipo(resultado['equipo_perdedor_id']);
                  final partidoId = resultado['partido_id'];
                  final nombreCampeonato = obtenerNombreCampeonato(partidoId);

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
                            AssetImage('assets/images/resultado_icono.png'),
                        backgroundColor: Colors.black,
                      ),
                      title: Text(
                        '💠 Competencia: $nombreCampeonato',
                        style: estilo_seccion,
                      ),
                      subtitle: Text(
                        '🏆 Ganador: $nombreGanador\n❌ Perdedor: $nombrePerdedor',
                        style: estilo_dato,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                title: Text(
                                  'Confirmación',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  '¿Estás seguro de querer eliminar este resultado?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancelar',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Aceptar',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      eliminarResultado(resultado['id']);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CrearResultado(
                onResultadoCreado: () {
                  // Actualiza la lista de resultados
                  cargarResultados();
                },
              ),
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
