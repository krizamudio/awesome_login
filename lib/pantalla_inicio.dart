import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'pantalla_login.dart';
import 'maps.dart';

class PantallaInicio extends StatefulWidget {
  final Map<String, dynamic> usuario;
  final Function(bool) onThemeChanged;

  const PantallaInicio({super.key, required this.usuario, required this.onThemeChanged});

  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

// Clase que representa la pantalla de inicio de sesión exitoso
class _PantallaInicioState extends State<PantallaInicio> with TickerProviderStateMixin {
  late AnimationController _controller; // Controlador de la animación
  late Animation<double> _animation; // Animación de la fuente

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animación de la fuente  
    _animation = Tween<double>(begin: 20, end: 30).animate(_controller) // Inicia la animación
      ..addListener(() { // Actualiza el estado de la pantalla
        setState(() {}); 
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFFECE5DD),
        title: Center(
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Bienvenido ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24.0,
                  ),
                ),
                TextSpan(
                  text: widget.usuario['usuario'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF25D366),
                    fontSize: _animation.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(),
        vsync: this,
        child: const Center(
          child: Text(
            '¡Inicio de sesión exitoso!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF25D366),
              fontSize: 24.0,
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    FloatingActionButton(
      onPressed: () {
        _mostrarConfirmacionCierreSesion(context);
      },
      backgroundColor: const Color(0xFF25D366),
      child: const Icon(Icons.logout),
    ),
    const SizedBox(height: 10), // Espaciado entre los botones
    FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MapsScreen(), // Clase principal de maps.dart
          ),
        );
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.map),
    ),
  ],
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
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF128C7E),
              ),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaLogin(onThemeChanged: widget.onThemeChanged),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF25D366),
              ),
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );
  }
  
}
