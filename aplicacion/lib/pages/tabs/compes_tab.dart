import 'package:aplicacion/widgets/seccion_titulo.dart';
import 'package:flutter/material.dart';

class CompesTab extends StatefulWidget {
  const CompesTab({super.key});

  @override
  State<CompesTab> createState() => _CompesTabState();
}

class _CompesTabState extends State<CompesTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo_compes.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            Text('data')
          ],
        ),
      ),     
    );
  }
}