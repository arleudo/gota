import 'dart:convert';
import 'package:gota/models/user.dart';
import 'package:gota/utils/constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseurl = '${Constants.baseUrl}user';

  Future<User?> login(String email, String password) async {
    final url = Uri.parse('$baseurl/login');
    final body = {'email': email, 'password': password};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return User.fromJson(responseData);
    } else {
      return null;
    }
  }
}
