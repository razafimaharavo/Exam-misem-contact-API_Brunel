import 'package:flutter/material.dart';
import 'package:first_project_flutter/services/api_service.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;

  UserDetailScreen({required this.userId});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final data = await ApiService.getUser(widget.userId);
      setState(() {
        user = data;
      });
    } catch (error) {
      setState(() {
        user = {};
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des détails utilisateur')),
      );
    }
  }

  void _confirmDelete() async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation"),
        content: Text("Voulez-vous vraiment supprimer cet utilisateur ?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Annuler")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Supprimer")),
        ],
      ),
    );

    if (confirmed) {
      await ApiService.deleteUser(widget.userId);
      Navigator.pushNamed(context, '/users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Détails du contact")),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : user!.isEmpty
              ? Center(child: Text("Aucun détail disponible"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user!['image'] != null)
                        Image.network(
                          'http://127.0.0.1:8000/ImageContact/${user!['image']}',
                          height: 150,
                          width: 150,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                        ),
                      SizedBox(height: 16),
                      Text('Nom: ${user!['name']}', style: TextStyle(fontSize: 18)),
                      Text('Prénom: ${user!['first_name']}', style: TextStyle(fontSize: 18)),
                      Text('Numéro téléphone: ${user!['numTel']}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 20),
                      ElevatedButton(onPressed: _confirmDelete, child: Text("Supprimer")),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/userEdit', arguments: widget.userId),
                        child: Text("Modifier"),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/users'),
                        child: Text("Retour"),
                      ),
                    ],
                  ),
                ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:first_project_flutter/services/api_service.dart';

// class UserDetailScreen extends StatefulWidget {
//   final int userId;

//   UserDetailScreen({required this.userId});

//   @override
//   _UserDetailScreenState createState() => _UserDetailScreenState();
// }

// class _UserDetailScreenState extends State<UserDetailScreen> {
//   Map<String, dynamic>? user;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUser();
//   }

//   Future<void> _fetchUser() async {
//     final data = await ApiService.getUser(widget.userId);
//     setState(() {
//       user = data;
//     });
//   }

//     void _confirmDelete() async {
//     final confirmed = await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Confirmation"),
//         content: Text("Voulez-vous vraiment supprimer cet utilisateur ?"),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Annuler")),
//           TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Supprimer")),
//         ],
//       ),
//     );

//     if (confirmed) {
//       await ApiService.deleteUser(widget.userId);
//       Navigator.pushNamed(context, '/users');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Détails du contact")),
//       body: user == null
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Image.network('http://127.0.0.1:8000/ImageContact/${user!['image']}'),
//                 Text('Nom: ${user!['name']}'),
//                 Text('Prénom: ${user!['first_name']}'),
//                 Text('Numéro téléphone: ${user!['numTel']}'),
//                 ElevatedButton(onPressed: _confirmDelete, child: Text("Supprimer")),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushNamed(context, '/userEdit', arguments: widget.userId),
//                   child: Text("Modifier"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushNamed(context, '/users'),
//                   child: Text("Retour"),
//                 ),
//               ],
//             ),
//     );
//   }
// }
