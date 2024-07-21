// import 'package:flutter/material.dart';

// class UserCard extends StatelessWidget {
//   final Map user;

//   UserCard({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: Image.network(
//           'http://127.0.0.1:8000/ImageContact/${user['image']}',
//           width: 50,
//           height: 50,
//           fit: BoxFit.cover,
//         ),
//         title: Text('${user['name']} ${user['first_name']}'),
//         subtitle: Text(user['numTel']),
//         onTap: () {
//           Navigator.pushNamed(context, '/userDetail', arguments: user['id']);
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Map user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          'http://127.0.0.1:8000/ImageContact/${user['image']}',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error);
          },
        ),
        title: Text('${user['name']} ${user['first_name']}'),
        subtitle: Text(user['numTel']),
        onTap: () {
          Navigator.pushNamed(context, '/userDetail', arguments: user['id']);
        },
      ),
    );
  }
}
