import 'package:flutter/material.dart';

class EquiposTab extends StatefulWidget {
  const EquiposTab({super.key});

  @override
  State<EquiposTab> createState() => _EquiposTabState();
}

class _EquiposTabState extends State<EquiposTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_equipo.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit: BoxFit.cover)
        ),
      ),
    );
  }
}