import 'package:aplicacion/screens/tabs/calendario_tab.dart';
import 'package:aplicacion/screens/tabs/compes_tab.dart';
import 'package:aplicacion/screens/tabs/equipos_tab.dart';
import 'package:aplicacion/screens/tabs/resultados_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle estilo_titulo = TextStyle(fontSize: 25,fontWeight: FontWeight.bold ,color: Colors.white);
    return Center(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Esport Tournament 🎮', style: estilo_titulo),
            backgroundColor: Colors.black,
            bottom:
             TabBar(
              //hace scrolleable el tabBar
              //isScrollable: true,
              //estilo de las tabs
              labelStyle: TextStyle(color: Colors.yellow[600]),
              unselectedLabelStyle: TextStyle(color: Colors.grey),
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