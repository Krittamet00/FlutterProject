import 'package:flutter/material.dart';
import '../widgets/floating_button.dart';
import 'add_entry_form.dart';
import 'add_debt_form.dart';
import '../services/db_helper.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<Map<String, dynamic>> _transactions = [];
  final DBHelper _dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final transactions = await _dbHelper.getTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transactions')),
      body: _transactions.isEmpty
          ? Center(child: Text('No transactions available'))
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                return _buildTransactionCard(transaction);
              },
            ),
      floatingActionButton: FloatingButton(
        onAddEntry: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEntryForm()),
          );
          _fetchTransactions(); // Refresh the list after returning from the form
        },
        onAddDebt: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDebtForm()),
          );
          _fetchTransactions(); // Refresh the list after returning from the form
        },
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction['type'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Category: ${transaction['category']}'),
            Text('Amount: \$${transaction['amount'].toStringAsFixed(2)}'),
            Text('Date: ${transaction['date']}'),
            if (transaction['note'] != null && transaction['note'].isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Note: ${transaction['note']}'),
              ),
          ],
        ),
      ),
    );
  }
}
