import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:story_app/core/constants/app_url.dart';
import 'package:story_app/data/model/auth/login_response_model.dart';
import 'package:story_app/data/model/response/response_model.dart';

class StoryAuthRemoteDataSource {
  final http.Client client;

  StoryAuthRemoteDataSource(this.client);

  Map<String, String> _headers() => {'Content-Type': 'application/json'};

  Future<LoginResult> login(String email, String password) async {
    final response = await client.post(
      Uri.parse(AppUrl.login),
      headers: _headers(),
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

  Future<ResponseModel> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await client.post(
        Uri.parse(AppUrl.register),
        headers: _headers(),
        body: jsonEncode({
          'name': username,
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final responseData = ResponseModel.fromJson(data);
        return responseData;
      } else {
        throw http.ClientException(
          'Failed to post : ${response.statusCode}',
          Uri.parse(AppUrl.register),
        );
      }
    } catch (e) {
      throw Exception('Error fetching stories: $e');
    }
  }
}
