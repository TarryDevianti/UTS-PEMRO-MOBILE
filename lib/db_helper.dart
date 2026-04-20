import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> initDB() async {
    final path = await getDatabasesPath();

    return openDatabase(
      join(path, 'karyawan.db'),
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
    final db = await initDB();
    return db.insert('karyawan', data);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await initDB();
    return db.query('karyawan');
  }

  static Future<int> update(int id, Map<String, dynamic> data) async {
    final db = await initDB();
    return db.update('karyawan', data, where: 'id=?', whereArgs: [id]);
  }

  static Future<int> delete(int id) async {
    final db = await initDB();
    return db.delete('karyawan', where: 'id=?', whereArgs: [id]);
  }
}