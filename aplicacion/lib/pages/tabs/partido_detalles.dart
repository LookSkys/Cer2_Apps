import 'package:aplicacion/widgets/appBar_seccion.dart';
import 'package:flutter/material.dart';

class PartidoDetalles extends StatelessWidget {
  final dynamic partido;
  final List<String> nombresEquipos;

  PartidoDetalles(
      {Key? key, required this.partido, required this.nombresEquipos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarSeccion(nombre_appbar: 'Detalle partido 📆'),
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
                'Fecha: ${partido['fecha']}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Lugar: ${partido['lugar']}',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Equipos Participantes:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ...nombresEquipos
                  .map((nombre) => Text(
                        '😼 $nombre',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ))
                  .toList(),
              if (nombresEquipos.isEmpty)
                Text(
                  'No hay equipos participantes registrados para este partido.',
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
