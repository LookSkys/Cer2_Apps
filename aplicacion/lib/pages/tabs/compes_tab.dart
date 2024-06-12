import 'package:aplicacion/pages/tabs/compe_detalles.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

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
      print('Campeonatos cargados: $listaCampeonatos');
      List<dynamic> listaEquipos = await httpService.equipos();
      print('Equipos cargados: $listaEquipos');
      List<dynamic> listaCampeonatoEquipo =
          await httpService.campeonatoEquipo();
      print('Campeonato-Equipo relaciones cargadas: $listaCampeonatoEquipo');
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
    print('Obteniendo nombres de equipos para el campeonato ID: $campeonatoId');
    List<int> idsEquipos = campeonatoEquipo
        .where((ce) => ce['campeonato_id'] == campeonatoId)
        .map<int>((ce) => ce['equipo_id'])
        .toList();
    print('IDs de equipos para el campeonato $campeonatoId: $idsEquipos');

    List<String> nombresEquipos = equipos
        .where((equipo) => idsEquipos.contains(equipo['id']))
        .map<String>((equipo) => equipo['nombre'])
        .toList();
    print(
        'Nombres de equipos para el campeonato $campeonatoId: $nombresEquipos');

    return nombresEquipos;
  }

  @override
  Widget build(BuildContext context) {
    print('Construyendo widget');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit: BoxFit.cover),
        ),
        child: ListView.builder(
          itemCount: campeonatos.length,
          itemBuilder: (context, index) {
            final campeonato = campeonatos[index];
            final nombresEquipos = obtenerNombresEquipos(campeonato['id']);
            print(
                'Construyendo ListTile para el campeonato: ${campeonato['nombre']}');
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
                  backgroundImage: AssetImage('assets/images/compes_icono.png'),
                  backgroundColor: Colors.black,
                ),
                title: Text(
                  '💠 ${campeonato['nombre']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  'Fecha: ${campeonato['fecha_inicio']}',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  print(
                      'Navegando a detalles del campeonato: ${campeonato['nombre']}');
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
              ),
            );
          },
        ),
      ),
    );
  }
}
