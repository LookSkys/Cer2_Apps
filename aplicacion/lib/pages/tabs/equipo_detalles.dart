import 'package:aplicacion/widgets/appBar_seccion.dart';
import 'package:flutter/material.dart';

class EquipoDetalles extends StatelessWidget {
  const EquipoDetalles({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle estilo_seccion = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white);

    TextStyle estilo_dato =
        TextStyle(fontSize: 17, color: Colors.white);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarSeccion(nombre_appbar: '⚔️  Campeonato'),
      body: 
      Container(        
        height: 250,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 100),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal, width: 7),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Detalles',
                  style: estilo_seccion,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Nombre:',
                  style: estilo_dato,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Inicio:',
                  style: estilo_dato,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Finaliza:',
                  style: estilo_dato,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Reglas:',
                  style: estilo_dato,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Premios:',
                  style: estilo_dato,
                )
              ],
            ),
          ],
        ),
      )      
    );
  }
}