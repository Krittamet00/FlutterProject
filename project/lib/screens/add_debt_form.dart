import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AddDebtForm extends StatefulWidget {
  @override
  _AddDebtFormState createState() => _AddDebtFormState();
}

class _AddDebtFormState extends State<AddDebtForm> {
  final TextEditingController _debtNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _category = AppConstants.expenseCategories.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Debt')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _debtNameController,
              decoration: InputDecoration(labelText: 'Debt Name'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _category,
              items: AppConstants.expenseCategories
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
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save the debt logic here
                Navigator.pop(context);
              },
              child: Text('Save Debt'),
            ),
          ],
        ),
      ),
    );
  }
}
