import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class CrearEquipo extends StatefulWidget {
  const CrearEquipo({Key? key}) : super(key: key);

  @override
  _CrearEquipoState createState() => _CrearEquipoState();
}

class _CrearEquipoState extends State<CrearEquipo> {
  final HttpService httpService = HttpService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _entrenadorController = TextEditingController();
  TextEditingController _juegosController = TextEditingController();

  List<String> _convertirStringALista(String texto) {
    return texto
        .split(',')
        .map((e) => e.trim())
        .toList(); // Convierte el string separado por comas a una lista
  }

  Future<void> crearEquipo() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final nuevoEquipo = {
          'nombre': _nombreController.text,
          'entrenador': _entrenadorController.text,
          'juegos_en_donde_participa':
              _convertirStringALista(_juegosController.text),
        };

        bool creado = await httpService.crearEquipo(nuevoEquipo);
        if (creado) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Equipo creado correctamente'),
            duration: Duration(seconds: 2),
          ));
          // Volver a la página anterior o donde sea necesario
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error al crear equipo'),
            duration: Duration(seconds: 2),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al crear equipo: $e'),
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
          'Crear Equipo',
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
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre del equipo'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del equipo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _entrenadorController,
                  decoration: InputDecoration(labelText: 'Entrenador'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del entrenador';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _juegosController,
                  decoration: InputDecoration(
                      labelText:
                          'Juegos en donde participa (separados por coma)'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese los juegos en donde participa el equipo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: crearEquipo,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.teal),
                  ),
                  child: Text(
                    'Crear equipo',
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
