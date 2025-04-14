import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/data/datasources/local/auth_local_datasource.dart';
import 'package:story_app/data/datasources/remote/story_auth_remote_datasource.dart';
import 'package:story_app/data/model/auth/login_response_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthLocalDataSource localDataSource;
  final StoryAuthRemoteDataSource dataSource;

  AuthProvider(this.dataSource, this.localDataSource);

  LoginResult? _loginResult;
  bool _isLoading = false;
  String? _error;

  LoginResult? get loginResult => _loginResult;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await dataSource.login(email, password);
      _loginResult = result;
      await localDataSource.saveToken(_loginResult!.token);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() async {
    await localDataSource.clearToken();
    _loginResult = null;
    notifyListeners();
  }
}
