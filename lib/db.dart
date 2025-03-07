import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AyudanteBaseDatos {
  static final AyudanteBaseDatos _instancia = AyudanteBaseDatos._interno();
  factory AyudanteBaseDatos() => _instancia;
  static Database? _baseDatos;

  final String tablaUsuarios = 'usuarios';
  final String columnaId = 'id';
  final String columnaUsuario = 'usuario';
  final String columnaContrasenia = 'contraseña';

  AyudanteBaseDatos._interno();

  Future<Database> get baseDatos async {
    if (_baseDatos != null) return _baseDatos!;
    _baseDatos = await _inicializarBaseDatos();
    return _baseDatos!;
  }

  Future<Database> _inicializarBaseDatos() async {
    String ruta = join(await getDatabasesPath(), 'base_datos_app.db');
    return await openDatabase(
      ruta,
      version: 1,
      onCreate: _crearBaseDatos,
    );
  }

  Future<void> _crearBaseDatos(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tablaUsuarios (
        $columnaId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnaUsuario TEXT UNIQUE,
        $columnaContrasenia TEXT
      )
    ''');
  }

  Future<int> insertarUsuario(Map<String, dynamic> usuario) async {
    Database db = await baseDatos;
    return await db.insert(tablaUsuarios, usuario);
  }

  Future<Map<String, dynamic>?> obtenerUsuario(String usuario, String contrasenia) async {
    Database db = await baseDatos;
    List<Map> resultado = await db.query(
      tablaUsuarios,
      where: '$columnaUsuario = ? AND $columnaContrasenia = ?',
      whereArgs: [usuario, contrasenia],
    );
    return resultado.isNotEmpty ? resultado.first as Map<String, dynamic> : null;
  }
}