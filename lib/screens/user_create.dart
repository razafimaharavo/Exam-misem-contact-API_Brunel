// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../services/api_service.dart';

// class UserCreateScreen extends StatefulWidget {
//   @override
//   _UserCreateScreenState createState() => _UserCreateScreenState();
// }

// class _UserCreateScreenState extends State<UserCreateScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String name = '';
//   String firstName = '';
//   String numTel = '';
//   XFile? _image;

//   void _createUser() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         String? imagePath = _image != null ? _image!.path : null;
//         final response = await ApiService().createUser({
//           'name': name,
//           'first_name': firstName,
//           'numTel': numTel,
//           'image': imagePath,
//         });

//         if (response.statusCode == 200) {
//           Navigator.pushNamed(context, '/users');
//         } else {
//           throw Exception('Failed to create user');
//         }
//       } catch (error) {
//         print('Erreur lors de la création: $error');
//       }
//     }
//   }

//   void _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = pickedFile;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Création de contact')),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 onSaved: (value) => name = value!,
//                 validator: (value) => value!.isEmpty ? 'Entrez un nom' : null,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'First Name'),
//                 onSaved: (value) => firstName = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Entrez un prénom' : null,
//               ),
//               TextFormField(
//                 decoration:
//                     const InputDecoration(labelText: 'Telephone Number'),
//                 onSaved: (value) => numTel = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Entrez un numéro' : null,
//               ),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: const Text('Choisir une image'),
//               ),
//               _image != null ? Image.network(_image!.path) : Container(),
//               ElevatedButton(
//                 onPressed: _createUser,
//                 child: const Text('Create'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';
import 'dart:io';

class UserCreateScreen extends StatefulWidget {
  @override
  _UserCreateScreenState createState() => _UserCreateScreenState();
}

class _UserCreateScreenState extends State<UserCreateScreen> {
  final _nameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _numTelController = TextEditingController();
  XFile? _image;
  final ApiService _apiService = ApiService();

  void _createUser() async {
    try {
      String? imagePath = _image != null ? _image!.path : null;
      final response = await _apiService.createUser({
        'name': _nameController.text,
        'first_name': _firstNameController.text,
        'numTel': _numTelController.text,
        'image': imagePath,
      });

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/users');
      } else {
        // Handle error
        print('Erreur lors de la création: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Erreur lors de la création: $error');
    }
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _firstNameController.dispose();
    _numTelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Création de contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _numTelController,
              decoration: const InputDecoration(labelText: 'Telephone Number'),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Choisir une image'),
            ),
            // _image != null ? Image.file(File(_image!.path)) : Container(),
            _image != null ? Image.network(_image!.path) : Container(),
            ElevatedButton(
              onPressed: _createUser,
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
