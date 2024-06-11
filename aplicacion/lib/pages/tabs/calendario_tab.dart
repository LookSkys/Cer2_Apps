import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class CalendarioTab extends StatefulWidget {
  const CalendarioTab({Key? key}) : super(key: key);

  @override
  _CalendarioTabState createState() => _CalendarioTabState();
}

class _CalendarioTabState extends State<CalendarioTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_equipo.jpg');
  final HttpService httpService = HttpService(); // Instancia de tu HttpService
  List<dynamic> partidos = []; // Lista para almacenar los equipos

  @override
  void initState() {
    super.initState();
    cargarPartidos(); // Cargar equipos al inicializar la página
  }

  Future<void> cargarPartidos() async {
    try {
      List<dynamic> listaPartidos = await httpService.partidos();
      setState(() {
        partidos = listaPartidos;
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
          itemCount: partidos.length,
          itemBuilder: (context, index) {
            // Aquí construyes los elementos para cada equipo
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black
                    .withOpacity(0.9), // Fondo blanco semitransparente
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.teal,
                  width: 2.0,
                )
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/equipo_icono.png'),
                ),
                title: Text(
                  '⚪ ' + partidos[index]['fecha'],
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text('Lugar: ' + partidos[index]['lugar'],
                style: TextStyle(color: Colors.white),)
                ,
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
