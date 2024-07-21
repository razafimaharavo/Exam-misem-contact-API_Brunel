import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LogoutButton extends StatelessWidget {
  final String token;

  LogoutButton({required this.token});

  void _logout(BuildContext context) async {
    try {
      await ApiService().logout(token);
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      print('Erreur de déconnexion: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _logout(context),
      child: const Text('Logout'),
    );
  }
}
