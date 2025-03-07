import 'package:flutter/material.dart';
import 'pantalla_login.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación con Login',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: PantallaLogin(),
    );
  }
}