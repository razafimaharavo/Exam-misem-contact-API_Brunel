import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../components/user_card.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    try {
      final data = await ApiService().getUsers();
      setState(() {
        users = data;
        loading = false;
      });
    } catch (error) {
      print('Erreur lors du chargement: $error');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des contacts')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserCard(user: users[index]);
              },
            ),
    );
  }
}
