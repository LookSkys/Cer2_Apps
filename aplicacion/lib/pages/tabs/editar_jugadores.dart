import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class EditarJugadores extends StatefulWidget {
  final int equipoId;

  const EditarJugadores(
      {Key? key,
      required this.equipoId,
      required void Function() actualizarJugadores})
      : super(key: key);

  @override
  _EditarJugadoresEquipoState createState() => _EditarJugadoresEquipoState();
}

class _EditarJugadoresEquipoState extends State<EditarJugadores> {
  final HttpService httpService = HttpService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _rutController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();

  Future<void> agregarJugador() async {
    if (_formKey.currentState?.validate() ?? false) {
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
          // Cerrar la pantalla actual para actualizar la anterior
          Navigator.pop(context);
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _rutController,
                  decoration: InputDecoration(labelText: 'RUT del jugador'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el RUT del jugador';
                    }
                    // Aquí puedes agregar validaciones adicionales para el formato del RUT
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre del jugador'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del jugador';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _apellidoController,
                  decoration:
                      InputDecoration(labelText: 'Apellido del jugador'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el apellido del jugador';
                    }
                    return null;
                  },
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
      ),
    );
  }
}
