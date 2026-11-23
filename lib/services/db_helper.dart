import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/medicamento.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'meditrack.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE medicamentos(
            id TEXT PRIMARY KEY,
            nombre TEXT,
            dosis TEXT,
            frecuencia TEXT,
            proximaDosis TEXT,
            estado TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertarMedicamento(Medicamento medicamento) async {
    final db = await database;
    await db.insert('medicamentos', medicamento.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Medicamento>> obtenerMedicamentos() async {
    final db = await database;
    final List < Map < String , dynamic > > maps = await db.query('medicamentos');
    return List.generate(maps.length, (i) => Medicamento.fromMap(maps[i]));
  }

  static Future<void> actualizarEstado(String id, String nuevoEstado) async {
    final db = await database;
    await db.update(
      'medicamentos',
      {'estado': nuevoEstado},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> eliminarMedicamento(String id) async {
    final db = await database;
    await db.delete(
      'medicamentos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}