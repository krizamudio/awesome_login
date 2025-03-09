import 'package:flutter/material.dart';
import 'pantalla_login.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatefulWidget {
  const MiAplicacion({super.key});

  @override
  _MiAplicacionState createState() => _MiAplicacionState();
}

class _MiAplicacionState extends State<MiAplicacion> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación con Login',
      theme: ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: PantallaLogin(onThemeChanged: _toggleTheme),
    );
  }
}