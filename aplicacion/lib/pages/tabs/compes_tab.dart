import 'package:aplicacion/pages/tabs/agregar_compe.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion/pages/tabs/compe_detalles.dart';
import 'package:aplicacion/pages/tabs/edit_compe.dart'; // Importa la pantalla de edición
import 'package:aplicacion/services/http_service.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class CompesTab extends StatefulWidget {
  const CompesTab({Key? key}) : super(key: key);

  @override
  _CompesTabState createState() => _CompesTabState();
}

class _CompesTabState extends State<CompesTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_equipo.jpg');
  final HttpService httpService = HttpService();
  List<dynamic> campeonatos = [];
  List<dynamic> equipos = [];
  List<dynamic> campeonatoEquipo = [];

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    try {
      List<dynamic> listaCampeonatos = await httpService.campeonatos();
      List<dynamic> listaEquipos = await httpService.equipos();
      List<dynamic> listaCampeonatoEquipo =
          await httpService.campeonatoEquipo();
      setState(() {
        campeonatos = listaCampeonatos;
        equipos = listaEquipos;
        campeonatoEquipo = listaCampeonatoEquipo;
      });
    } catch (e) {
      print('Error al cargar campeonatos, equipos o relaciones: $e');
    }
  }

  List<String> obtenerNombresEquipos(int campeonatoId) {
    List<int> idsEquipos = campeonatoEquipo
        .where((ce) => ce['campeonato_id'] == campeonatoId)
        .map<int>((ce) => ce['equipo_id'])
        .toList();

    List<String> nombresEquipos = equipos
        .where((equipo) => idsEquipos.contains(equipo['id']))
        .map<String>((equipo) => equipo['nombre'])
        .toList();

    return nombresEquipos;
  }

  Future<void> eliminarCampeonato(int campeonatoId) async {
    try {
      bool eliminado = await httpService.eliminarCampeonato(campeonatoId);
      if (eliminado) {
        // Actualizar lista después de eliminar
        await cargarDatos();
        // Mostrar un mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Campeonato eliminado correctamente'),
          duration: Duration(seconds: 2),
        ));
      } else {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al eliminar campeonato'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al eliminar campeonato'),
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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: fondo, fit: BoxFit.cover),
          ),
          child: campeonatos.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal, // Cambia el color aquí
                  ),
                )
              : ListView.builder(
                  itemCount:
                      campeonatos.length + 1, // Incrementa el count por 1
                  itemBuilder: (context, index) {
                    if (index == campeonatos.length) {
                      return SizedBox(
                          height: 80); // Espacio para el botón flotante
                    }
                    final campeonato = campeonatos[index];
                    final nombresEquipos =
                        obtenerNombresEquipos(campeonato['id']);
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompeDetalles(
                                campeonato: campeonato,
                                nombresEquipos: nombresEquipos,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/compes_icono.png'),
                              backgroundColor: Colors.black,
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '💠 ${campeonato['nombre']}',
                                    style: estiloSeccion,
                                  ),
                                  Text(
                                    'Fecha: ${campeonato['fecha_inicio']}',
                                    style: estiloDato,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditCompe(campeonato: campeonato),
                                  ),
                                ).then((value) {
                                  // Actualizar lista después de editar
                                  if (value == true) {
                                    cargarDatos();
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
                                          '¿Estás seguro de querer eliminar este campeonato?'),
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
                                            eliminarCampeonato(
                                                campeonato['id']);
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
        ),
        //BOTON AGREGAR
        floatingActionButton: FloatingActionButton(
          child: Icon(
            MdiIcons.plus,
            color: Colors.white,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.teal,
          onPressed: () {
            MaterialPageRoute ruta = MaterialPageRoute(
              builder: (context) => CreateCompe(),
            );
            Navigator.push(context, ruta).then((value) {
              setState(() {});
            });
          },
        ),
      ),
    );
  }
}
