import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';
import 'package:intl/intl.dart';

class CreateCompe extends StatefulWidget {
  @override
  _CreateCompeState createState() => _CreateCompeState();
}

class _CreateCompeState extends State<CreateCompe> {
  final HttpService httpService = HttpService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _fechaInicioController = TextEditingController();
  TextEditingController _fechaFinController = TextEditingController();
  TextEditingController _reglasController = TextEditingController();
  TextEditingController _premiosController = TextEditingController();

  List<dynamic> equiposDisponibles = [];
  List<int> equiposSeleccionados = [];

  @override
  void initState() {
    super.initState();
    cargarEquiposDisponibles();
  }

  Future<void> cargarEquiposDisponibles() async {
    try {
      List<dynamic> listaEquipos = await httpService.equipos();
      setState(() {
        equiposDisponibles = listaEquipos;
      });
    } catch (e) {
      print('Error al cargar equipos disponibles: $e');
    }
  }

  Future<void> vincularEquipos(int campeonatoId) async {
    try {
      for (int equipoId in equiposSeleccionados) {
        await httpService.vincularEquipo(campeonatoId, equipoId);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Equipos vinculados correctamente'),
        duration: Duration(seconds: 2),
      ));
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al vincular equipos'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> crearCampeonato() async {
    if (_formKey.currentState!.validate()) {
      final nuevoCampeonato = {
        'nombre': _nombreController.text,
        'fecha_inicio': _fechaInicioController.text,
        'fecha_fin': _fechaFinController.text,
        'reglas': _reglasController.text,
        'premios': _premiosController.text,
      };

      final campeonatoId = await httpService.crearCampeonato(nuevoCampeonato);
      if (campeonatoId != null) {
        // Vincular equipos seleccionados al campeonato creado
        await vincularEquipos(campeonatoId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al crear campeonato'),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese una fecha';
    }
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (e) {
      return 'Formato de fecha inválido (yyyy-MM-dd)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Crear Campeonato', style: TextStyle(color: Colors.white)),
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
                  decoration:
                      InputDecoration(labelText: 'Nombre del campeonato'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del campeonato';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _fechaInicioController,
                  decoration: InputDecoration(labelText: 'Fecha de inicio'),
                  style: TextStyle(color: Colors.white),
                  validator: _validateDate,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _fechaFinController,
                  decoration: InputDecoration(labelText: 'Fecha de fin'),
                  style: TextStyle(color: Colors.white),
                  validator: _validateDate,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _reglasController,
                  decoration: InputDecoration(labelText: 'Reglas'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese las reglas';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _premiosController,
                  decoration: InputDecoration(labelText: 'Premios'),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese los premios';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('Añadir Equipos',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(height: 8.0),
                equiposDisponibles.isEmpty
                    ? Text('No hay equipos disponibles',
                        style: TextStyle(color: Colors.white))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: equiposDisponibles.length,
                        itemBuilder: (context, index) {
                          final equipo = equiposDisponibles[index];
                          return CheckboxListTile(
                            title: Text(equipo['nombre'],
                                style: TextStyle(color: Colors.white)),
                            value: equiposSeleccionados.contains(equipo['id']),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  equiposSeleccionados.add(equipo['id']);
                                } else {
                                  equiposSeleccionados.remove(equipo['id']);
                                }
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.teal,
                          );
                        },
                      ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.teal),
                  ),
                  onPressed: crearCampeonato,
                  child: Text('Crear Campeonato',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
