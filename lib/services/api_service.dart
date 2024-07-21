import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000';

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

   Future<void> createUser(String name, String firstName, String numTel, String? imagePath) async {
    final response = await http.post(
      Uri.parse('$baseUrl/contacts'),
      body: json.encode({
        'name': name,
        'first_name': firstName,
        'numTel': numTel,
        'image': imagePath,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create user');
    }
  }

  Future<List> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/contacts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
}






