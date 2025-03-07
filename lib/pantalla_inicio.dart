import 'package:flutter/material.dart';
import 'pantalla_login.dart';

class PantallaInicio extends StatelessWidget {
  final Map<String, dynamic> usuario;

  const PantallaInicio({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido ${usuario['usuario']}'),
      ),
      body: const Center(
        child: Text('¡Inicio de sesión exitoso!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarConfirmacionCierreSesion(context);
        },
        child: const Icon(Icons.logout),
      ),
    );
  }

  void _mostrarConfirmacionCierreSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaLogin()),
                );
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );
  }
}