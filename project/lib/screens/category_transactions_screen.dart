import 'package:flutter/material.dart';
import '../services/db_helper.dart';

class CategoryTransactionsScreen extends StatefulWidget {
  final String category;
  final String type; // "Income" or "Expense"

  CategoryTransactionsScreen({required this.category, required this.type});

  @override
  _CategoryTransactionsScreenState createState() => _CategoryTransactionsScreenState();
}

class _CategoryTransactionsScreenState extends State<CategoryTransactionsScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<Map<String, dynamic>> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final transactions = await _dbHelper.getTransactionsByCategory(widget.category, widget.type);
    setState(() {
      _transactions = transactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} - ${widget.category}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _transactions.isEmpty
            ? Center(child: Text('No transactions available for this category.'))
            : ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  return ListTile(
                    leading: Icon(Icons.monetization_on, color: widget.type == 'Income' ? Colors.green : Colors.red),
                    title: Text('\$${transaction['amount'].toStringAsFixed(2)}'),
                    subtitle: Text(transaction['note'] ?? 'No note'),
                    trailing: Text(transaction['date']),
                  );
                },
              ),
      ),
    );
  }
}
