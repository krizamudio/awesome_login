import 'package:flutter/material.dart';
import 'db.dart';
import 'package:animated_background/animated_background.dart';
import 'pantalla_inicio.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  _EstadoPantallaLogin createState() => _EstadoPantallaLogin();
}

class _EstadoPantallaLogin extends State<PantallaLogin> with TickerProviderStateMixin {
  final _claveFormulario = GlobalKey<FormState>();
  final TextEditingController _controladorUsuario = TextEditingController();
  final TextEditingController _controladorContrasenia = TextEditingController();
  final AyudanteBaseDatos _ayudanteBD = AyudanteBaseDatos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'App-Login SQLite',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(),
        vsync: this,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _claveFormulario,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: _controladorUsuario,
                          decoration: InputDecoration(
                            labelText: 'Usuario',
                            filled: true,
                            fillColor: Colors.lightGreen[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'Por favor ingrese su usuario';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: _controladorContrasenia,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            filled: true,
                            fillColor: Colors.lightGreen[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          validator: (valor) {
                            if (valor == null || valor.isEmpty) {
                              return 'Por favor ingrese su contraseña';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: _iniciarSesion,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                          backgroundColor: const Color(0xFF25D366),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Ingresar'),
                      ),
                      TextButton(
                        onPressed: _mostrarRegistro,
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF25D366),
                        ),
                        child: const Text('Crear nueva cuenta'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'KriZamudio © 2025',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _iniciarSesion() async {
    if (_claveFormulario.currentState!.validate()) {
      final usuario = await _ayudanteBD.obtenerUsuario(
        _controladorUsuario.text,
        _controladorContrasenia.text,
      );
      
      if (usuario != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PantallaInicio(usuario: usuario)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    }
  }

  void _mostrarRegistro() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registrar usuario'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controladorUsuario,
              decoration: InputDecoration(
                hintText: 'Usuario',
                filled: true,
                fillColor: Colors.lightGreen[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            TextField(
              controller: _controladorContrasenia,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                filled: true,
                fillColor: Colors.lightGreen[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final resultado = await _ayudanteBD.insertarUsuario({
                'usuario': _controladorUsuario.text,
                'contraseña': _controladorContrasenia.text
              });
              
              if (resultado > 0) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Usuario creado con éxito')),
                );
              }
            },
            child: const Text('Registrar'),
          ),
        ],
      ),
    );
  }
}