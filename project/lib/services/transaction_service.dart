import 'package:sqflite/sqflite.dart';
import '../models/transaction_model.dart';
import '../models/debt_model.dart';
import 'database_service.dart';

class TransactionService {
  final DatabaseService _databaseService = DatabaseService();

  Future<int> addTransaction(TransactionModel transaction) async {
    final db = await _databaseService.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<TransactionModel>> getTransactions() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');

    return List.generate(maps.length, (i) {
      return TransactionModel.fromMap(maps[i]);
    });
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    final db = await _databaseService.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await _databaseService.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> addDebt(DebtModel debt) async {
    final db = await _databaseService.database;
    return await db.insert('debts', debt.toMap());
  }

  Future<List<DebtModel>> getDebts() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('debts');

    return List.generate(maps.length, (i) {
      return DebtModel.fromMap(maps[i]);
    });
  }

  Future<int> updateDebt(DebtModel debt) async {
    final db = await _databaseService.database;
    return await db.update(
      'debts',
      debt.toMap(),
      where: 'id = ?',
      whereArgs: [debt.id],
    );
  }

  Future<int> deleteDebt(int id) async {
    final db = await _databaseService.database;
    return await db.delete(
      'debts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
