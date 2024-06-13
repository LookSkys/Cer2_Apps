import 'package:aplicacion/widgets/appBar_seccion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipoDetalles extends StatelessWidget {
  final dynamic equipo;
  final List<String> jugadores;

  EquipoDetalles({Key? key, required this.equipo, required this.jugadores})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> juegosParticipa = equipo['juegos_en_donde_participa'] != null
        ? List<String>.from(equipo['juegos_en_donde_participa'])
        : [];
    final double screenWidth = MediaQuery.of(context).size.width;

    //Estilos para texto
    TextStyle estilo_nombre = GoogleFonts.oswald(
        textStyle: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white));
    TextStyle estilo_seccion = GoogleFonts.oswald(
        textStyle: TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white));
    TextStyle estilo_dato = GoogleFonts.oswald(
        textStyle: TextStyle(fontSize: 17, color: Colors.white));

    return Scaffold(
      appBar: AppbarSeccion(nombre_appbar: 'Detalle Equipo 👥'),
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
                Text('${equipo['nombre']}', style: estilo_nombre),
                SizedBox(height: 10),
                Text('🧔 Entrenador: ${equipo['entrenador']}',
                    style: estilo_dato),
                SizedBox(height: 20),
                Text('Jugadores:', style: estilo_seccion),
                ...jugadores
                    .map((nombre) => Text(
                          '😼 $nombre',
                          style: estilo_dato,
                        ))
                    .toList(),
                if (jugadores.isEmpty)
                  Text('No hay jugadores registrados en este equipo.',
                      style: estilo_dato),
                SizedBox(height: 20),
                Text('Juegos en donde participa:', style: estilo_seccion),
                ...juegosParticipa
                    .map((juego) => Text(
                          '🎮 $juego',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ))
                    .toList(),
                if (juegosParticipa.isEmpty)
                  Text('Este equipo no participa en ningún juego.',
                      style: estilo_dato),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
