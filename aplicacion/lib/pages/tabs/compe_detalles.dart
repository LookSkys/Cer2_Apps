import 'package:aplicacion/widgets/appBar_seccion.dart';
import 'package:flutter/material.dart';

class CompeDetalles extends StatelessWidget {
  final dynamic campeonato;
  final List<String> nombresEquipos;

  const CompeDetalles(
      {Key? key, required this.campeonato, required this.nombresEquipos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtiene el ancho de la pantalla
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarSeccion(nombre_appbar: 'Detalle Campeonato ⚔️'),
      body: Container(
        color: Colors.black, // Fondo negro
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth, // Establece el ancho del container
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.teal,
                width: 2.0,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${campeonato['nombre']}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Fecha de Inicio: ${campeonato['fecha_inicio']}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Fecha de Fin: ${campeonato['fecha_fin']}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'Equipos Participantes:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                ...nombresEquipos
                    .map((nombre) => Text(
                          '- $nombre',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ))
                    .toList(),
                if (nombresEquipos.isEmpty)
                  Text(
                    'No hay equipos participantes disponibles',
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
