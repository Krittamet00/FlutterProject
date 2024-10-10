import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart';

class ChangeThemeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Theme')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.light_mode),
              title: Text('Light Theme'),
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(false);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Theme'),
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(true);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
