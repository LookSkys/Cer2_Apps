import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class EquiposTab extends StatefulWidget {
  const EquiposTab({Key? key}) : super(key: key);

  @override
  _EquiposTabState createState() => _EquiposTabState();
}

class _EquiposTabState extends State<EquiposTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_equipo.jpg');
  final HttpService httpService = HttpService(); // Instancia de tu HttpService
  List<dynamic> equipos = []; // Lista para almacenar los equipos

  @override
  void initState() {
    super.initState();
    cargarEquipos(); // Cargar equipos al inicializar la página
  }

  Future<void> cargarEquipos() async {
    try {
      List<dynamic> listaEquipos = await httpService.equipos();
      setState(() {
        equipos = listaEquipos;
      });
    } catch (e) {
      print('Error al cargar equipos: $e');
    }
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
            // Aquí construyes los elementos para cada equipo
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.3), // Fondo blanco semitransparente
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  equipos[index]['nombre'],
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(equipos[index]['entrenador']),
                // Agrega más información según tu API
                onTap: () {
                  // Acciones al hacer tap en un equipo si es necesario
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
