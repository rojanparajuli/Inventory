import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'inventory.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      quantity INTEGER
    )
    ''');
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    Database db = await database;
    return db.query('items');
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    Database db = await database;
    return db.insert('items', item);
  }

  Future<int> updateItem(Map<String, dynamic> item) async {
    Database db = await database;
    return db.update('items', item, where: 'id = ?', whereArgs: [item['id']]);
  }

  Future<int> deleteItem(int id) async {
    Database db = await database;
    return db.delete('items', where: 'id = ?', whereArgs: [id]);
  }
}
