import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:noteplus_app/const/api_config.dart';
import 'package:noteplus_app/model/auth-model.dart';

class AuthRepository {
  final String _baseUrl;

  AuthRepository({String? baseUrl}) : _baseUrl = baseUrl ?? ApiConfig.baseUrl;

  Future<AuthenticateModel> login({
    required String username,
    required String password,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/auth_service/credential');

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    final dynamic decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final body = decoded['body'] as Map<String, dynamic>?;
      if (body == null) {
        throw Exception('Invalid response from server.');
      }
      return AuthenticateModel.fromJson(body);
    } else {
      final message = decoded is Map<String, dynamic>
          ? (decoded['message'] as String?) ?? 'Authentication failed.'
          : 'Authentication failed.';
      throw Exception(message);
    }
  }
}

