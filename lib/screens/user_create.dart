import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class UserCreateScreen extends StatefulWidget {
  @override
  _UserCreateScreenState createState() => _UserCreateScreenState();
}

class _UserCreateScreenState extends State<UserCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String firstName = '';
  String numTel = '';
  XFile? _image;

  void _createUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        String? imagePath = _image != null ? _image!.path : null;
        await ApiService().createUser(name, firstName, numTel, imagePath);
        Navigator.pushNamed(context, '/users');
      } catch (error) {
        print('Erreur lors de la création: $error');
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Création de contact')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              onSaved: (value) => name = value!,
              validator: (value) => value!.isEmpty ? 'Entrez un nom' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'First Name'),
              onSaved: (value) => firstName = value!,
              validator: (value) => value!.isEmpty ? 'Entrez un prénom' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Telephone Number'),
              onSaved: (value) => numTel = value!,
              validator: (value) => value!.isEmpty ? 'Entrez un numéro' : null,
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Choisir une image'),
            ),
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
