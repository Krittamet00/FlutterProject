import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Dummy variables for demonstration (in a real app, fetch these from your database or authentication service)
  String _storedUsername = 'currentUsername';
  String _storedPassword = 'currentPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'New Username',
                  hintText: 'Enter your new username',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  hintText: 'Enter your current password',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  hintText: 'Confirm your new password',
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    final newUsername = _usernameController.text.trim();
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validate current password
    if (currentPassword != _storedPassword) {
      _showErrorDialog('Current password is incorrect.');
      return;
    }

    // Validate new password and confirm password
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog('New password fields cannot be empty.');
      return;
    }

    if (newPassword != confirmPassword) {
      _showErrorDialog('New passwords do not match.');
      return;
    }

    // Perform username and password update logic here
    // Example: Update in your database or authentication service
    setState(() {
      _storedUsername = newUsername.isEmpty ? _storedUsername : newUsername;
      _storedPassword = newPassword;
    });

    _showSuccessDialog('Profile updated successfully!');
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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
