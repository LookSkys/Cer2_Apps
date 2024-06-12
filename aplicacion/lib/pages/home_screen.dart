import 'package:aplicacion/pages/tabs/calendario_tab.dart';
import 'package:aplicacion/pages/tabs/compes_tab.dart';
import 'package:aplicacion/pages/tabs/equipos_tab.dart';
import 'package:aplicacion/pages/tabs/resultados_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //Estilos para texto
        TextStyle estilo_nombre = GoogleFonts.oswald(textStyle:  TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white));
    TextStyle estilo_seleccionado = GoogleFonts.oswald(textStyle:  TextStyle(
        fontSize: 15,
        color: Colors.teal));
    TextStyle estilo_deseleccionado = GoogleFonts.oswald(textStyle:  TextStyle(
        fontSize: 15,
        color: Colors.white));

    return Center(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Esport Tournament 🎮®', style: estilo_nombre),
            backgroundColor: Colors.black,
            bottom: TabBar(
              //hace scrolleable el tabBar
              //isScrollable: true,
              //estilo de las tabs
              labelStyle: estilo_seleccionado,
              unselectedLabelStyle: estilo_deseleccionado,
              tabs: [
                Tab(     
                  text: 'Competiciones',
                  icon: Icon(MdiIcons.tournament),
                ),
                Tab(
                  text: 'Equipos',
                  icon: Icon(MdiIcons.accountGroupOutline),
                ),
                Tab(
                  text: 'Calendario',
                  icon: Icon(Icons.calendar_month),
                ),
                Tab(
                  text: 'Resultados',
                  icon: Icon(MdiIcons.trophy),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CompesTab(),
              EquiposTab(),
              CalendarioTab(),
              ResultadosTab(),
            ],
          ),
        ),
      ),
    );
  }
}
