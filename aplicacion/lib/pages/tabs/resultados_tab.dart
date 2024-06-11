import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class ResultadosTab extends StatefulWidget {
  const ResultadosTab({Key? key}) : super(key: key);

  @override
  _ResultadosTabState createState() => _ResultadosTabState();
}

class _ResultadosTabState extends State<ResultadosTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_equipo.jpg');
  final HttpService httpService = HttpService(); // Instancia de tu HttpService
  List<dynamic> resultados = []; // Lista para almacenar los equipos

  @override
  void initState() {
    super.initState();
    cargarResultados(); // Cargar equipos al inicializar la página
  }

  Future<void> cargarResultados() async {
    try {
      List<dynamic> listaResultados = await httpService.resultados();
      setState(() {
        resultados = listaResultados;
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
          itemCount: resultados.length,
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
                  backgroundImage: AssetImage('assets/images/resultado_icono.png'),
                  backgroundColor: Colors.black,
                ),
                title: Text(
                  '⚪ ' + resultados[index]['equipo_ganador_id'].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text('Entrenador: ' + resultados[index]['equipo_perdedor_id'].toString(),
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
