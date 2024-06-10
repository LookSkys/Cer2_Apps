import 'package:flutter/material.dart';

class SeccionTitulo extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const SeccionTitulo({required this.titulo, required this.subtitulo});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.titulo)
        ],
      ),
    );
  }
}