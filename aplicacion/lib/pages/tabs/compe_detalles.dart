import 'package:aplicacion/widgets/appBar_seccion.dart';
import 'package:flutter/material.dart';

class CompeDetalles extends StatelessWidget {
  const CompeDetalles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('HOLAAAA'),
      appBar: AppbarSeccion(nombre_appbar: 'Campeonato')      
    );
  }
}