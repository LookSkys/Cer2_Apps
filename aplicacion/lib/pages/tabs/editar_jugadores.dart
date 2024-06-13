import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class EditarJugadores extends StatefulWidget {
  final int equipoId;

  const EditarJugadores({Key? key, required this.equipoId}) : super(key: key);

  @override
  _EditarJugadoresEquipoState createState() => _EditarJugadoresEquipoState();
}

class _EditarJugadoresEquipoState extends State<EditarJugadores> {
  final HttpService httpService = HttpService();
  TextEditingController _rutController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();

  Future<void> agregarJugador() async {
    try {
      final nuevoJugador = {
        'rut': _rutController.text,
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'equipo_id': widget.equipoId,
      };

      bool agregado = await httpService.agregarJugador(nuevoJugador);
      if (agregado) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Jugador agregado correctamente'),
          duration: Duration(seconds: 2),
        ));
        // Limpiar los campos después de agregar el jugador
        _rutController.clear();
        _nombreController.clear();
        _apellidoController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al agregar jugador'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al agregar jugador: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Agregar Jugador al Equipo',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _rutController,
                decoration: InputDecoration(labelText: 'RUT del jugador'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del jugador'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _apellidoController,
                decoration: InputDecoration(labelText: 'Apellido del jugador'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: agregarJugador,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.teal),
                ),
                child: Text(
                  'Agregar Jugador',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
