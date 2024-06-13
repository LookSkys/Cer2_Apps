import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class EditarEquipo extends StatefulWidget {
  final Map<String, dynamic> equipo;

  const EditarEquipo({Key? key, required this.equipo, required equipoId})
      : super(key: key);

  @override
  _EditarDatosEquipoState createState() => _EditarDatosEquipoState();
}

class _EditarDatosEquipoState extends State<EditarEquipo> {
  final HttpService httpService = HttpService();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _entrenadorController = TextEditingController();
  TextEditingController _juegosController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nombreController.text = widget.equipo['nombre'];
    _entrenadorController.text = widget.equipo['entrenador'];
    _juegosController.text =
        _convertirListaAString(widget.equipo['juegos_en_donde_participa']);
  }

  String _convertirListaAString(List<dynamic> lista) {
    return lista
        .join(', '); // Convierte la lista a un string separado por comas
  }

  List<String> _convertirStringALista(String texto) {
    return texto
        .split(',')
        .map((e) => e.trim())
        .toList(); // Convierte el string separado por comas a una lista
  }

  Future<void> editarEquipo() async {
    try {
      final datosEditados = {
        'id': widget.equipo['id'],
        'nombre': _nombreController.text,
        'entrenador': _entrenadorController.text,
        'juegos_en_donde_participa':
            _convertirStringALista(_juegosController.text),
      };

      bool editado = await httpService.editarEquipos(datosEditados);
      if (editado) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Equipo editado correctamente'),
          duration: Duration(seconds: 2),
        ));
        // Actualizar la página de detalles del equipo
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al editar equipo'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al editar equipo: $e'),
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
          'Editar Datos del Equipo',
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
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del equipo'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _entrenadorController,
                decoration: InputDecoration(labelText: 'Entrenador'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _juegosController,
                decoration: InputDecoration(
                    labelText:
                        'Juegos en donde participa (separados por coma)'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: editarEquipo,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                ),
                child: Text(
                  'Guardar cambios',
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
