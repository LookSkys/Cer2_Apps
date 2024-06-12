import 'package:aplicacion/widgets/appBar_seccion.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarSeccion(nombre_appbar: 'Detalle Equipo 👥'),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: const EdgeInsets.all(16.0),
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
              Text(
                'Nombre: ${equipo['nombre']}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Entrenador: ${equipo['entrenador']}',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Jugadores:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ...jugadores
                  .map((nombre) => Text(
                        '- $nombre',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ))
                  .toList(),
              if (jugadores.isEmpty)
                Text(
                  'No hay jugadores registrados en este equipo.',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Juegos en donde participa:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ...juegosParticipa
                  .map((juego) => Text(
                        '- $juego',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ))
                  .toList(),
              if (juegosParticipa.isEmpty)
                Text(
                  'Este equipo no participa en ningún juego.',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
