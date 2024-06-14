import 'package:aplicacion/widgets/appBar_seccion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PartidoDetalles extends StatelessWidget {
  final dynamic partido;
  final List<String> nombresEquipos;

  PartidoDetalles(
      {Key? key, required this.partido, required this.nombresEquipos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    //Estilos para texto
    TextStyle estilo_seccion = GoogleFonts.oswald(
        textStyle: TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white));
    TextStyle estilo_dato = GoogleFonts.oswald(
        textStyle: TextStyle(fontSize: 17, color: Colors.white));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarSeccion(nombre_appbar: 'Detalle partido 📆'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/fondo_detalles.jpeg'),
              fit: BoxFit.cover),
        ),
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            padding: const EdgeInsets.all(35.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.teal,
                width: 2.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('👤 Equipos Participantes:', style: estilo_seccion),
                SizedBox(height: 10),
                ...nombresEquipos
                    .map((nombre) => Text(
                          '• $nombre',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ))
                    .toList(),
                if (nombresEquipos.isEmpty)
                  Text(
                      'No hay equipos participantes registrados para este partido.',
                      style: estilo_dato),
                SizedBox(height: 30),
                Text(
                  '📅 Fecha: ',
                  style: estilo_seccion,
                ),
                SizedBox(height: 10),
                Text('• ${partido['fecha']}', style: estilo_dato),
                SizedBox(height: 30),
                Text(
                  '🗺 Lugar',
                  style: estilo_seccion,
                ),
                SizedBox(height: 10),
                Text('• ${partido['lugar']}', style: estilo_dato),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
