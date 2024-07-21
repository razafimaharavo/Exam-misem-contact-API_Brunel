import 'package:flutter/material.dart';
import 'package:first_project_flutter/screens/logout_button.dart';
import 'package:first_project_flutter/screens/user_list.dart';
import 'package:first_project_flutter/screens/user_create.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatelessWidget {
  final storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await storage.read(key: 'token');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Gérer le cas où le token n'est pas trouvé ou est vide
          return Center(child: Text('Erreur d\'authentification'));
        }

        final token = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text('Accueil')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserListScreen()),
                    );
                  },
                  child: Text('Voir la liste des utilisateurs'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserCreateScreen()),
                    );
                  },
                  child: Text('Ajouter un utilisateur'),
                ),
                SizedBox(height: 20),
                LogoutButton(token: token),
              ],
            ),
          ),
        );
      },
    );
  }
}
