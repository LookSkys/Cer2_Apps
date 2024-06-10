import 'package:flutter/material.dart';

class CompesTab extends StatefulWidget {
  const CompesTab({super.key});

  @override
  State<CompesTab> createState() => _CompesTabState();
}

class _CompesTabState extends State<CompesTab> {
  final AssetImage fondo = AssetImage('assets/images/fondo1.jpg');

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