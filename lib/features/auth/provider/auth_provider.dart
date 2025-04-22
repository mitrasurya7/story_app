import 'package:flutter/material.dart';
import 'package:story_app/core/extension/context_extension.dart';
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

  String _email = '';
  String _password = '';

  LoginResult? get loginResult => _loginResult;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get email => _email;
  String get password => _password;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await dataSource.login(_email, _password);
      _loginResult = result;
      await localDataSource.saveToken(_loginResult!.token);
    } catch (e) {
      _error = context.l10n.errorLogin;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() async {
    await localDataSource.clearToken();
    _loginResult = null;
    _email = '';
    _password = '';
    notifyListeners();
  }
}
