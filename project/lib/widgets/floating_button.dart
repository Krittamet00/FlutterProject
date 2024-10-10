import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback onAddEntry;
  final VoidCallback onAddDebt;

  FloatingButton({required this.onAddEntry, required this.onAddDebt});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAddOptions(context);
      },
      child: Icon(Icons.add),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Add Entry'),
              onTap: () {
                Navigator.pop(context);
                onAddEntry();
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Add Debt'),
              onTap: () {
                Navigator.pop(context);
                onAddDebt();
              },
            ),
          ],
        );
      },
    );
  }
}
