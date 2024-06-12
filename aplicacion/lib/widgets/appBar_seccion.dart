import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarSeccion extends StatelessWidget implements PreferredSizeWidget {
  final String nombre_appbar;
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  AppbarSeccion({required this.nombre_appbar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        this.nombre_appbar,
        style: GoogleFonts.oswald(textStyle:TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}
