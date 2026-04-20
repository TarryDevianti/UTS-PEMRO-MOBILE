import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'karyawan.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE karyawan(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            jabatan TEXT,
            gaji_pokok INTEGER,
            tunjangan INTEGER,
            potongan INTEGER,
            total_gaji INTEGER
          )
        ''');
      },
    );
  }

  static Future<int> insert(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('karyawan', data);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await database;
    return await db.query('karyawan');
  }

  static Future<int> update(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('karyawan', data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('karyawan', where: 'id = ?', whereArgs: [id]);
  }
}