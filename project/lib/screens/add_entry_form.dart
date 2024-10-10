import 'package:flutter/material.dart';
import '../services/db_helper.dart';
import '../utils/constants.dart';

class AddEntryForm extends StatefulWidget {
  @override
  _AddEntryFormState createState() => _AddEntryFormState();
}

class _AddEntryFormState extends State<AddEntryForm> {
  String _type = AppConstants.incomeType; // Default to 'Income'
  String _category = AppConstants.incomeCategories.first; // Default category
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Dropdown for selecting type (Income/Expense)
              DropdownButtonFormField<String>(
                value: _type,
                items: [AppConstants.incomeType, AppConstants.expenseType]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                    _category = _type == AppConstants.incomeType
                        ? AppConstants.incomeCategories.first
                        : AppConstants.expenseCategories.first;
                  });
                },
                decoration: InputDecoration(labelText: 'Type'),
              ),
              SizedBox(height: 16),
              // Dropdown for selecting category based on type
              DropdownButtonFormField<String>(
                value: _category,
                items: (_type == AppConstants.incomeType
                        ? AppConstants.incomeCategories
                        : AppConstants.expenseCategories)
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 16),
              // TextField for entering the amount
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              SizedBox(height: 16),
              // TextField for entering an optional note
              TextField(
                controller: _noteController,
                decoration: InputDecoration(labelText: 'Note (Optional)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEntry,
                child: Text('Save Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveEntry() async {
    // Validate the amount field
    if (_amountController.text.isEmpty) {
      _showErrorDialog('Please enter an amount.');
      return;
    }

    try {
      // Parse the amount and prepare the transaction data
      final double amount = double.parse(_amountController.text);
      final dbHelper = DBHelper();
      final transaction = {
        'type': _type,
        'category': _category,
        'amount': amount,
        'date': DateTime.now().toIso8601String(),
        'note': _noteController.text,
      };

      // Insert the transaction into the database
      await dbHelper.insertTransaction(transaction);

      // Close the form and return to the previous screen
      Navigator.pop(context);
    } catch (e) {
      _showErrorDialog('Error saving entry. Please ensure the amount is valid and try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers to free resources
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
