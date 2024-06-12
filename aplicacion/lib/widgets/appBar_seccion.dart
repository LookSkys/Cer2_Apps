import 'package:flutter/material.dart';

class AppbarSeccion extends StatelessWidget implements PreferredSizeWidget{
final String nombre_appbar;
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
AppbarSeccion({required this.nombre_appbar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
              backgroundColor: Colors.black,
              title: Text(
                this.nombre_appbar,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white)
            );
  }
}