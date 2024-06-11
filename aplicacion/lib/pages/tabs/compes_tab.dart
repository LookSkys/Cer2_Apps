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
  final HttpService httpService = HttpService(); // Instancia de tu HttpService
  List<dynamic> campeonatos = []; // Lista para almacenar los equipos

  @override
  void initState() {
    super.initState();
    cargar(); // Cargar equipos al inicializar la página
  }

  Future<void> cargar() async {
    try {
      List<dynamic> listaCampeonatos = await httpService.campeonatos();
      setState(() {
        campeonatos = listaCampeonatos;
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
          itemCount: campeonatos.length,
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
                  backgroundImage: AssetImage('assets/images/compes_icono.png'),
                  backgroundColor: Colors.black,
                ),
                title: Text(
                  '⚪ ' + campeonatos[index]['nombre'],
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text('Fecha: ' + campeonatos[index]['fecha_inicio'],
                style: TextStyle(color: Colors.white),)
                ,
                // Agrega más información según tu API
                onTap: () {
                  // Acciones al hacer tap en un equipo si es necesario
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CompeDetalles()));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
