import 'package:flutter/material.dart';
import 'package:aplicacion/services/http_service.dart';

class EditCompe extends StatefulWidget {
  final Map<String, dynamic> campeonato;

  const EditCompe({Key? key, required this.campeonato}) : super(key: key);

  @override
  _EditCompeState createState() => _EditCompeState();
}

class _EditCompeState extends State<EditCompe> {
  final HttpService httpService = HttpService();
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
    _nombreController.text = widget.campeonato['nombre'];
    _fechaInicioController.text = widget.campeonato['fecha_inicio'];
    _fechaFinController.text = widget.campeonato['fecha_fin'];
    _reglasController.text = widget.campeonato['reglas'];
    _premiosController.text = widget.campeonato['premios'];
    cargarEquiposDisponibles();
  }

  Future<void> cargarEquiposDisponibles() async {
    try {
      List<dynamic> listaEquipos = await httpService.equipos();
      List<dynamic> listaCampeonatoEquipo =
          await httpService.campeonatoEquipo();
      List<int> idsEquiposEnCampeonato = listaCampeonatoEquipo
          .where((ce) => ce['campeonato_id'] == widget.campeonato['id'])
          .map<int>((ce) => ce['equipo_id'])
          .toList();

      setState(() {
        equiposDisponibles = listaEquipos
            .where((equipo) => !idsEquiposEnCampeonato.contains(equipo['id']))
            .toList();
      });
    } catch (e) {
      print('Error al cargar equipos disponibles: $e');
    }
  }

  Future<void> vincularEquipos() async {
    try {
      for (int equipoId in equiposSeleccionados) {
        await httpService.vincularEquipo(widget.campeonato['id'], equipoId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Editar Campeonato',
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
                decoration: InputDecoration(labelText: 'Nombre del campeonato'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _fechaInicioController,
                decoration: InputDecoration(labelText: 'Fecha de inicio'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _fechaFinController,
                decoration: InputDecoration(labelText: 'Fecha de fin'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _reglasController,
                decoration: InputDecoration(labelText: 'Reglas'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _premiosController,
                decoration: InputDecoration(labelText: 'Premios'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              Text(
                'Añadir Equipos',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 8.0),
              equiposDisponibles.isEmpty
                  ? Text(
                      'No hay equipos disponibles',
                      style: TextStyle(color: Colors.white),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: equiposDisponibles.length,
                      itemBuilder: (context, index) {
                        final equipo = equiposDisponibles[index];
                        return CheckboxListTile(
                          title: Text(
                            equipo['nombre'],
                            style: TextStyle(color: Colors.white),
                          ),
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
                onPressed: () async {
                  // Guardar cambios del campeonato
                  widget.campeonato['nombre'] = _nombreController.text;
                  widget.campeonato['fecha_inicio'] =
                      _fechaInicioController.text;
                  widget.campeonato['fecha_fin'] = _fechaFinController.text;
                  widget.campeonato['reglas'] = _reglasController.text;
                  widget.campeonato['premios'] = _premiosController.text;

                  bool editado =
                      await httpService.editarCampeonato(widget.campeonato);
                  if (editado) {
                    // Vincular equipos seleccionados
                    await vincularEquipos();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error al editar campeonato'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
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
