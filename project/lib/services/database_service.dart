import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();
  static Database? _database;

  DatabaseService._();

  factory DatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('savings_management.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Create users table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        username TEXT,
        password TEXT
      );
    ''');

    // Create transactions table
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY,
        type TEXT,
        category TEXT,
        amount REAL,
        date TEXT,
        note TEXT
      );
    ''');

    // Create debts table
    await db.execute('''
      CREATE TABLE debts (
        id INTEGER PRIMARY KEY,
        name TEXT,
        category TEXT,
        amount REAL,
        date TEXT,
        note TEXT
      );
    ''');
  }

  Future<void> close() async {
    final db = await database;
    if (db.isOpen) {
      await db.close();
    }
  }
}

