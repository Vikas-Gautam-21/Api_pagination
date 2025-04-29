import 'dart:convert';
import 'package:api_call/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'https://reqres.in/api';

  Future<UserResponse> getUsers(int page) async {
    final url = '$baseUrl/users?page=$page';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }
}
