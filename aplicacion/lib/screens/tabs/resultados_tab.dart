import 'package:flutter/material.dart';

class ResultadosTab extends StatefulWidget {
  const ResultadosTab({super.key});

  @override
  State<ResultadosTab> createState() => _ResultadosTabState();
}

class _ResultadosTabState extends State<ResultadosTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_resultados.jpg');


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