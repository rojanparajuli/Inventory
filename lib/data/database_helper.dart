import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
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
      version: 2, 
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      quantity INTEGER,
      sellingPrice REAL
    )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE items ADD COLUMN sellingPrice REAL');
    }
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

  Future<int> sellItem(int id, int quantityToSell) async {
    Database db = await database;
    Map<String, dynamic> item = (await db.query('items', where: 'id = ?', whereArgs: [id])).first;
    int newQuantity = item['quantity'] - quantityToSell;

    if (newQuantity >= 0) {
      item['quantity'] = newQuantity;
      return await updateItem(item);
    } else {
      throw Exception('Not enough items in stock to sell');
    }
  }
}
