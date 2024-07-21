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
//           errorBuilder: (context, error, stackTrace) {
//             return Icon(Icons.error);
//           },
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
import 'package:http/http.dart' as http;

class UserCard extends StatelessWidget {
  final Map user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FutureBuilder(
          future: fetchImage(user['image']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Image.network(
                  snapshot.data as String,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error);
              }
            }
            return CircularProgressIndicator();
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

  Future<String> fetchImage(String imageName) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/ImageContact/$imageName'),
      headers: {
        "Access-Control-Allow-Origin": "*",
      },
    );

    if (response.statusCode == 200) {
      return 'http://127.0.0.1:8000/ImageContact/$imageName';
    } else {
      throw Exception('Failed to load image');
    }
  }
}
