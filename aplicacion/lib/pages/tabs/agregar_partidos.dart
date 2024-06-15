import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class CrearPartido extends StatefulWidget {
  const CrearPartido({Key? key}) : super(key: key);

  @override
  _CrearPartidoState createState() => _CrearPartidoState();
}

class _CrearPartidoState extends State<CrearPartido> {
  final HttpService httpService = HttpService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fechaController = TextEditingController();
  TextEditingController _lugarController = TextEditingController();
  TextEditingController _horaController = TextEditingController();
  String? _campeonatoSeleccionado;
  List<String?> _equiposSeleccionados = [null, null];

  List<dynamic> _campeonatos = [];
  List<dynamic> _equipos = [];

  @override
  void initState() {
    super.initState();
    _obtenerCampeonatos();
    _obtenerEquipos();
  }

  Future<void> _obtenerCampeonatos() async {
    try {
      final campeonatos = await httpService.campeonatos();
      setState(() {
        _campeonatos = campeonatos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al obtener campeonatos: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> _obtenerEquipos() async {
    try {
      final equipos = await httpService.equipos();
      setState(() {
        _equipos = equipos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al obtener equipos: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> crearPartido() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final nuevoPartido = {
          'fecha': _fechaController.text,
          'hora': _horaController.text,
          'lugar': _lugarController.text,
          'campeonato_id': _campeonatoSeleccionado,
        };

        print(nuevoPartido);

        int? partidoId = await httpService.crearPartidos(nuevoPartido);
        if (partidoId != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Partido creado correctamente'),
            duration: Duration(seconds: 2),
          ));

          // Vincular los equipos al partido
          List<int> equipoIds = _equiposSeleccionados
              .where((equipo) => equipo != null)
              .map((equipo) => int.parse(equipo!))
              .toList();

          bool vinculado =
              await httpService.vincularEquiposAlPartido(partidoId, equipoIds);
          if (vinculado) {
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error al vincular equipos al partido'),
              duration: Duration(seconds: 2),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error al crear partido'),
            duration: Duration(seconds: 2),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al crear partido: $e'),
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
          'Crear Partido',
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
                  controller: _fechaController,
                  decoration: InputDecoration(labelText: 'Fecha del partido'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la fecha del partido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _horaController,
                  decoration: InputDecoration(labelText: 'Hora del partido'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la hora del partido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _lugarController,
                  decoration: InputDecoration(labelText: 'Lugar del partido'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el lugar del partido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  value: _campeonatoSeleccionado,
                  decoration: InputDecoration(labelText: 'Campeonato'),
                  style: TextStyle(color: Colors.white),
                  items: _campeonatos
                      .map((campeonato) => DropdownMenuItem(
                            value: campeonato['id'].toString(),
                            child: Text(
                              campeonato['nombre'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _campeonatoSeleccionado = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione un campeonato';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  value: _equiposSeleccionados[0],
                  decoration: InputDecoration(labelText: 'Equipo 1'),
                  style: TextStyle(color: Colors.white),
                  items: _equipos
                      .map((equipo) => DropdownMenuItem(
                            value: equipo['id'].toString(),
                            child: Text(
                              equipo['nombre'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _equiposSeleccionados[0] = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione el primer equipo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  value: _equiposSeleccionados[1],
                  decoration: InputDecoration(labelText: 'Equipo 2'),
                  style: TextStyle(color: Colors.white),
                  items: _equipos
                      .map((equipo) => DropdownMenuItem(
                            value: equipo['id'].toString(),
                            child: Text(
                              equipo['nombre'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _equiposSeleccionados[1] = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione el segundo equipo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: crearPartido,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.teal),
                  ),
                  child: Text(
                    'Crear partido',
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
