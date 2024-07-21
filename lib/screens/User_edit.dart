import 'package:flutter/material.dart';
import 'package:first_project_flutter/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserEditScreen extends StatefulWidget {
  final int userId;

  UserEditScreen({required this.userId});

  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  late TextEditingController nameController;
  late TextEditingController firstNameController;
  late TextEditingController numTelController;
  late String imageUrl;
  bool isLoading = true;
  List<String> errors = [];
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final data = await ApiService.getUser(widget.userId);
      setState(() {
        nameController = TextEditingController(text: data['name']);
        firstNameController = TextEditingController(text: data['first_name']);
        numTelController = TextEditingController(text: data['numTel']);
        imageUrl = 'http://127.0.0.1:8000/ImageContact/${data['image']}';
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errors = ['Erreur lors du chargement des données utilisateur'];
        isLoading = false;
      });
    }
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }

  Future<void> _updateUser() async {
    final updatedData = {
      'name': nameController.text,
      'first_name': firstNameController.text,
      'numTel': numTelController.text,
    };

    try {
      await ApiService.updateUser(widget.userId, updatedData, imageFile);
      Navigator.pushNamed(context, '/userDetail', arguments: widget.userId);
    } catch (error) {
      setState(() {
        errors = [''];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modification du contact")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (imageUrl.isNotEmpty)
                      Image.network(
                        imageUrl,
                        height: 150,
                        width: 150,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error),
                      ),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text("Choisir une image"),
                    ),
                    if (imageFile != null)
                      Image.network(imageFile!.path, height: 150, width: 150),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nom'),
                    ),
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(labelText: 'Prénom'),
                    ),
                    TextField(
                      controller: numTelController,
                      decoration:
                          InputDecoration(labelText: 'Numéro de téléphone'),
                      keyboardType: TextInputType.phone,
                    ),
                    ElevatedButton(
                      onPressed: _updateUser,
                      child: Text("Mettre à jour"),
                    ),
                    if (errors.isNotEmpty)
                      ...errors
                          .map((e) =>
                              Text(e, style: TextStyle(color: Colors.red)))
                          .toList(),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                          context, '/userDetail',
                          arguments: widget.userId),
                      child: Text("Retour aux détails"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
