import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class CrearResultado extends StatefulWidget {
  final VoidCallback? onResultadoCreado;

  const CrearResultado({Key? key, this.onResultadoCreado}) : super(key: key);

  @override
  _CrearResultadoState createState() => _CrearResultadoState();
}

class _CrearResultadoState extends State<CrearResultado> {
  final HttpService httpService = HttpService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _puntacionGanadorController = TextEditingController();
  TextEditingController _puntacionPerdedorController = TextEditingController();
  String? _partidoSeleccionado;
  String? _equipoGanadorSeleccionado;
  String? _equipoPerdedorSeleccionado;

  List<dynamic> _partidos = [];
  List<dynamic> _equipos = [];
  List<dynamic> _equipoPartido = [];

  @override
  void initState() {
    super.initState();
    _obtenerPartidos();
    _obtenerEquipos();
    _obtenerEquipoPartido();
  }

  Future<void> _obtenerPartidos() async {
    try {
      final partidos = await httpService.partidos();
      setState(() {
        _partidos = partidos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al obtener partidos: $e'),
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

  Future<void> _obtenerEquipoPartido() async {
    try {
      final equipoPartido = await httpService.equipoPartido();
      setState(() {
        _equipoPartido = equipoPartido;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al obtener equipo-partido: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  String obtenerDescripcionPartido(int partidoId) {
    final equiposEnPartido =
        _equipoPartido.where((ep) => ep['partido_id'] == partidoId).toList();
    if (equiposEnPartido.length < 2) {
      return 'Partido $partidoId'; // Por si falta información
    }

    final equipo1 = _equipos.firstWhere(
        (equipo) => equipo['id'] == equiposEnPartido[0]['equipo_id']);
    final equipo2 = _equipos.firstWhere(
        (equipo) => equipo['id'] == equiposEnPartido[1]['equipo_id']);

    return '${equipo1['nombre']} vs ${equipo2['nombre']}';
  }

  List<Map<String, dynamic>> obtenerEquiposEnPartido(int partidoId) {
    final equiposEnPartido =
        _equipoPartido.where((ep) => ep['partido_id'] == partidoId).toList();
    final List<Map<String, dynamic>> equipos = [];

    equiposEnPartido.forEach((ep) {
      final equipo =
          _equipos.firstWhere((equipo) => equipo['id'] == ep['equipo_id']);
      equipos.add({'id': equipo['id'], 'nombre': equipo['nombre']});
    });
    return equipos;
  }

  Future<void> crearResultado() async {
    // Convierte a enteros
    int puntacionGanadorInt = int.parse(_puntacionGanadorController.text);
    int puntacionPerdedorInt = int.parse(_puntacionPerdedorController.text);
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final nuevoResultado = {
          'puntuacion_ganador': puntacionGanadorInt,
          'puntuacion_perdedor': puntacionPerdedorInt,
          'partido_id': int.parse(_partidoSeleccionado!),
          'equipo_ganador_id': int.parse(_equipoGanadorSeleccionado!),
          'equipo_perdedor_id': int.parse(_equipoPerdedorSeleccionado!),
        };

        int? resultadoId = await httpService.crearResultados(nuevoResultado);
        if (resultadoId != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Resultado creado correctamente'),
            duration: Duration(seconds: 2),
          ));
          // Llama al callback para actualizar la lista en ResultadosTab
          widget.onResultadoCreado?.call();
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error al crear resultado'),
            duration: Duration(seconds: 2),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al crear resultado: $e'),
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
          'Crear Resultado',
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
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  value: _partidoSeleccionado,
                  decoration: InputDecoration(labelText: 'Partido'),
                  style: TextStyle(color: Colors.white),
                  items: _partidos
                      .map((partido) => DropdownMenuItem(
                            value: partido['id'].toString(),
                            child: Text(
                              obtenerDescripcionPartido(partido['id']),
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _partidoSeleccionado = value;
                      _equipoGanadorSeleccionado = null;
                      _equipoPerdedorSeleccionado = null;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione un partido';
                    }
                    return null;
                  },
                ),
                if (_partidoSeleccionado != null)
                  Column(
                    children: [
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.black,
                        value: _equipoGanadorSeleccionado,
                        decoration:
                            InputDecoration(labelText: 'Equipo Ganador'),
                        style: TextStyle(color: Colors.white),
                        items: obtenerEquiposEnPartido(
                                int.parse(_partidoSeleccionado!))
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
                            _equipoGanadorSeleccionado = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor seleccione el equipo ganador';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _puntacionGanadorController,
                        decoration:
                            InputDecoration(labelText: 'Puntuación Ganador'),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la puntuación del ganador';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.black,
                        value: _equipoPerdedorSeleccionado,
                        decoration:
                            InputDecoration(labelText: 'Equipo Perdedor'),
                        style: TextStyle(color: Colors.white),
                        items: obtenerEquiposEnPartido(
                                int.parse(_partidoSeleccionado!))
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
                            _equipoPerdedorSeleccionado = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor seleccione el equipo perdedor';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _puntacionPerdedorController,
                        decoration:
                            InputDecoration(labelText: 'Puntuación Perdedor'),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la puntuación del perdedor';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: crearResultado,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.teal),
                  ),
                  child: Text(
                    'Crear resultado',
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
