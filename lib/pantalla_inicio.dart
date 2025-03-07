import 'package:flutter/material.dart';
import 'pantalla_login.dart';

class PantallaInicio extends StatelessWidget {
  final Map<String, dynamic> usuario;

  const PantallaInicio({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Bienvenido ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: usuario['usuario'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF25D366),
                  ),
                ),
              ],
            ),
          ),
        ),
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
          backgroundColor: const Color(0xFFDCF8C6),
          title: const Text('Confirmación'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Cancelar'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF128C7E),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PantallaLogin()),
                );
              },
              child: const Text('Cerrar sesión'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF128C7E),
              ),
            ),
          ],
        );
      },
    );
  }
}