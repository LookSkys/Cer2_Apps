import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplicacion/pages/tabs/editar_jugadores.dart';
import 'package:aplicacion/widgets/appBar_seccion.dart';

class EquipoDetalles extends StatefulWidget {
  final dynamic equipo;
  final List<String> jugadores;

  EquipoDetalles({Key? key, required this.equipo, required this.jugadores})
      : super(key: key);

  @override
  _EquipoDetallesState createState() => _EquipoDetallesState();
}

class _EquipoDetallesState extends State<EquipoDetalles> {
  List<String> juegosParticipa = [];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Estilos para texto
    TextStyle estiloNombre = GoogleFonts.oswald(
        textStyle: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white));
    TextStyle estiloSeccion = GoogleFonts.oswald(
        textStyle: TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white));
    TextStyle estiloDato = GoogleFonts.oswald(
        textStyle: TextStyle(fontSize: 17, color: Colors.white));

    void actualizarJugadores() {
      setState(() {
        // Actualizar la lista de jugadores llamando a la API o a otra función que obtenga los datos actualizados
        // En este ejemplo, simplemente reasignamos jugadores con una lista vacía
        // Puedes reemplazar esto con la lógica adecuada para obtener los jugadores actualizados
        widget.jugadores.add('Nuevo Jugador'); // Solo para propósitos de prueba
      });
    }

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
                Container(
                    alignment: Alignment.center,
                    child: Text('${widget.equipo['nombre']}',
                        style: estiloNombre)),
                SizedBox(height: 30),
                Text(
                  '🧔 Entrenador:',
                  style: estiloSeccion,
                ),
                SizedBox(height: 10),
                Text('• ${widget.equipo['entrenador']}', style: estiloDato),
                SizedBox(height: 30),
                Text('👤 Jugadores:', style: estiloSeccion),
                SizedBox(height: 10),
                ...widget.jugadores
                    .map((nombre) => Text(
                          '• $nombre',
                          style: estiloDato,
                        ))
                    .toList(),
                if (widget.jugadores.isEmpty)
                  Text('No hay jugadores registrados en este equipo.',
                      style: estiloDato),
                SizedBox(height: 30),
                Text('🎮 Juegos en donde participa:', style: estiloSeccion),
                SizedBox(height: 10),
                ...juegosParticipa
                    .map((juego) => Text('• $juego', style: estiloDato))
                    .toList(),
                if (juegosParticipa.isEmpty)
                  Text('Este equipo no participa en ningún juego.',
                      style: estiloDato),
                SizedBox(height: 60),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarJugadores(
                            equipoId: widget.equipo['id'],
                            actualizarJugadores: actualizarJugadores,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.teal),
                    ),
                    child: Text(
                      'Agregar Jugador',
                      style: estiloSeccion,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
