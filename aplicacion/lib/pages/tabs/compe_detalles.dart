import 'package:aplicacion/widgets/appBar_seccion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.black,
      appBar: AppbarSeccion(nombre_appbar: 'Detalle Campeonato ⚔️'),
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
            width: screenWidth, // Establece el ancho del container
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.teal,
                width: 2.0,
              ),
            ),
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.center,
                    child:
                        Text('${campeonato['nombre']}', style: estilo_nombre)),
                SizedBox(height: 30),
                Text(
                  '📅 Fechas:',
                  style: estilo_seccion,
                ),
                SizedBox(height: 10),
                Text(
                  '• Inicio: ${campeonato['fecha_inicio']}',
                  style: estilo_dato,
                ),
                SizedBox(height: 10),
                Text(
                  '• Fin: ${campeonato['fecha_fin']}',
                  style: estilo_dato,
                ),
                SizedBox(height: 30),
                Text(
                  '📄 Reglas:',
                  style: estilo_seccion,
                ),
                SizedBox(height: 10),
                Text(
                  '• ${campeonato['reglas']}',
                  style: estilo_dato,
                ),
                SizedBox(height: 30),
                Text(
                  '🏆 Premios: ',
                  style: estilo_seccion,
                ),
                Text(
                  '• ${campeonato['premios']}',
                  style: estilo_dato,
                ),
                SizedBox(height: 30),
                Text('👥 Participantes:', style: estilo_seccion),
                SizedBox(height: 10),
                ...nombresEquipos
                    .map((nombre) => Text(
                          '😼 $nombre',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ))
                    .toList(),
                if (nombresEquipos.isEmpty)
                  Text('❌ No hay equipos participantes aún',
                      style: estilo_dato),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
