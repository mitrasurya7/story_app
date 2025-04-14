import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:story_app/core/constants/app_url.dart';
import 'package:story_app/data/model/auth/login_response_model.dart';

class StoryAuthRemoteDataSource {
  final http.Client client;

  StoryAuthRemoteDataSource(this.client);

  Future<LoginResult> login(String email, String password) async {
    final response = await client.post(
      Uri.parse(AppUrl.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final loginResponse = LoginResponseModel.fromJson(data);
      return loginResponse.loginResult;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
}
