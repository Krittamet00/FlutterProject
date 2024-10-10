import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import '../widgets/change_theme_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Change Theme'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeThemeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
