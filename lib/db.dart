import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Clase que ayuda a manejar la base de datos
class AyudanteBaseDatos {
 
  // Singleton para asegurar una única instancia de la base de datos
  static final AyudanteBaseDatos _instancia = AyudanteBaseDatos._interno();
  factory AyudanteBaseDatos() => _instancia;
  static Database? _baseDatos;

  // Nombre de la tabla de usuarios y sus columnas
  final String tablaUsuarios = 'usuarios';
  final String columnaId = 'id';
  final String columnaUsuario = 'usuario';
  final String columnaContrasenia = 'contraseña';

  // Constructor interno para el singleton
  AyudanteBaseDatos._interno();

  // Obtiene la instancia de la base de datos, inicializándola si es necesario
  Future<Database> get baseDatos async {
    if (_baseDatos != null) return _baseDatos!;
    _baseDatos = await _inicializarBaseDatos();
    return _baseDatos!;
  }

  // Inicializa la base de datos, creando el archivo en la ruta especificada
  Future<Database> _inicializarBaseDatos() async {
    String ruta = join(await getDatabasesPath(), 'base_datos_app.db');
    return await openDatabase(
      ruta,
      version: 1,
      onCreate: _crearBaseDatos,
    );
  }

  // Crea la tabla de usuarios en la base de datos
  Future<void> _crearBaseDatos(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tablaUsuarios (
        $columnaId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnaUsuario TEXT UNIQUE,
        $columnaContrasenia TEXT
      )
    ''');
  }

  // Inserta un nuevo usuario en la tabla de usuarios
  Future<int> insertarUsuario(Map<String, dynamic> usuario) async {
    Database db = await baseDatos;
    return await db.insert(tablaUsuarios, usuario);
  }

  // Obtiene un usuario de la tabla de usuarios basado en el nombre de usuario y la contraseña
  Future<Map<String, dynamic>?> obtenerUsuario(String usuario, String contrasenia) async {
    Database db = await baseDatos;
    List<Map> resultado = await db.query(
      tablaUsuarios,
      where: '$columnaUsuario = ? AND $columnaContrasenia = ?',
      whereArgs: [usuario, contrasenia],
    );
    return resultado.isNotEmpty ? resultado.first as Map<String, dynamic> : null;
  }

  // Obtiene un usuario de la tabla de usuarios basado en el nombre de usuario
  Future<Map<String, dynamic>?> obtenerUsuarioPorNombre(String nombreUsuario) async {
    final db = await baseDatos;
    final resultado = await db.query(
      'usuarios',
      where: 'usuario = ?',
      whereArgs: [nombreUsuario],
    );

    if (resultado.isNotEmpty) {
      return resultado.first;
    }
    return null;
  }
}