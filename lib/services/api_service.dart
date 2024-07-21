import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const  String baseUrl = 'http://127.0.0.1:8000';

  Future<http.Response> register(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/register'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  Future<http.Response> login(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  Future<http.Response> logout(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  Future<http.Response> createUser(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/contacts'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  Future<List> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/api/contacts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<Map<String, dynamic>> getUser(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/contacts/$id'));
    return jsonDecode(response.body);
  }

  static Future<void> updateUser(
      int id, Map<String, dynamic> data, XFile? imageFile) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/contacts/$id'));

    data.forEach((key, value) {
      request.fields[key] = value;
    });

    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    await request.send();
  }

  static Future<void> deleteUser(int id) async {
    await http.delete(Uri.parse('$baseUrl/contacts/$id'));
  }
}
