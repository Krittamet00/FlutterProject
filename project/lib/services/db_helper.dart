import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper() {
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
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT,
        name TEXT
      );
    ''');

    // Create transactions table
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
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
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        category TEXT,
        amount REAL,
        date TEXT,
        note TEXT
      );
    ''');
  }

  // User CRUD operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Transaction CRUD operations
  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    final db = await database;
    return await db.insert('transactions', transaction);
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await database;
    return await db.query('transactions', orderBy: 'date DESC');
  }

  Future<int> updateTransaction(int id, Map<String, dynamic> transaction) async {
    final db = await database;
    return await db.update(
      'transactions',
      transaction,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Debt CRUD operations
  Future<int> insertDebt(Map<String, dynamic> debt) async {
    final db = await database;
    return await db.insert('debts', debt);
  }

  Future<List<Map<String, dynamic>>> getDebts() async {
    final db = await database;
    return await db.query('debts', orderBy: 'date DESC');
  }

  Future<int> updateDebt(int id, Map<String, dynamic> debt) async {
    final db = await database;
    return await db.update(
      'debts',
      debt,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteDebt(int id) async {
    final db = await database;
    return await db.delete(
      'debts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Summary operations
  Future<double> getTotalIncome() async {
    final db = await database;
    final result = await db.rawQuery(
        "SELECT SUM(amount) as total FROM transactions WHERE type = ?", ['Income']);
    return result.first['total'] == null ? 0.0 : result.first['total'] as double;
  }

  Future<double> getTotalExpenses() async {
    final db = await database;
    final result = await db.rawQuery(
        "SELECT SUM(amount) as total FROM transactions WHERE type = ?", ['Expense']);
    return result.first['total'] == null ? 0.0 : result.first['total'] as double;
  }

  Future<double> getTotalDebts() async {
    final db = await database;
    final result = await db.rawQuery("SELECT SUM(amount) as total FROM debts");
    return result.first['total'] == null ? 0.0 : result.first['total'] as double;
  }

  // Fetch transactions based on category and type
  Future<List<Map<String, dynamic>>> getTransactionsByCategory(String category, String type) async {
    final db = await database;
    return await db.query(
      'transactions',
      where: 'category = ? AND type = ?',
      whereArgs: [category, type],
      orderBy: 'date DESC',
    );
  }

  // Summary based on a specific day
  Future<Map<String, double>> getDailySummary(DateTime date) async {
    final db = await database;
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final incomeResult = await db.rawQuery(
        "SELECT SUM(amount) as total FROM transactions WHERE type = ? AND date LIKE ?", 
        ['Income', '$formattedDate%']);
    final expenseResult = await db.rawQuery(
        "SELECT SUM(amount) as total FROM transactions WHERE type = ? AND date LIKE ?", 
        ['Expense', '$formattedDate%']);
    return {
      'income': incomeResult.first['total'] == null ? 0.0 : incomeResult.first['total'] as double,
      'expense': expenseResult.first['total'] == null ? 0.0 : expenseResult.first['total'] as double,
    };
  }

  // Summary based on the week (Monday to Sunday)
  Future<Map<String, double>> getWeeklySummary(DateTime date) async {
    final db = await database;
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1)); // Monday
    final endOfWeek = startOfWeek.add(Duration(days: 6)); // Sunday
    final String startDate = DateFormat('yyyy-MM-dd').format(startOfWeek);
    final String endDate = DateFormat('yyyy-MM-dd').format(endOfWeek);

    final incomeResult = await db.rawQuery(
        "SELECT SUM(amount) as total FROM transactions WHERE type = ? AND date BETWEEN ? AND ?", 
        ['Income', startDate, endDate]);
    final expenseResult = await db.rawQuery(
        "SELECT SUM(amount) as total FROM transactions WHERE type = ? AND date BETWEEN ? AND ?", 
        ['Expense', startDate, endDate]);
    return {
      'income': incomeResult.first['total'] == null ? 0.0 : incomeResult.first['total'] as double,
      'expense': expenseResult.first['total'] == null ? 0.0 : expenseResult.first['total'] as double,
    };
  }

  // Summary based on the month
  Future<Map<String, double>> getMonthlySummary(DateTime date) async {
    final db = await database;
    final String month = DateFormat('yyyy-MM').format(date);

    final incomeResult = await db.rawQuery(
        "SELECT SUM(amount) as total FROM transactions WHERE type = ? AND date LIKE ?", 
        ['Income', '$month%']);
    final expenseResult = await db.rawQuery(
        "SELECT SUM(amount) as total FROM transactions WHERE type = ? AND date LIKE ?", 
        ['Expense', '$month%']);
    return {
      'income': incomeResult.first['total'] == null ? 0.0 : incomeResult.first['total'] as double,
      'expense': expenseResult.first['total'] == null ? 0.0 : expenseResult.first['total'] as double,
    };
  }

  Future<void> close() async {
    final db = await database;
    if (db.isOpen) {
      await db.close();
    }
  }
}

