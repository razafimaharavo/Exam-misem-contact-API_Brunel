import 'package:flutter/material.dart';
import '../services/api_service.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;

  UserDetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails du contact')),
      body: Center(child: Text('Détails de l\'utilisateur $userId')),
    );
  }
}
