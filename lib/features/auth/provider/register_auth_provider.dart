import 'package:flutter/material.dart';
import 'package:story_app/core/extension/context_extension.dart';
import 'package:story_app/data/datasources/remote/story_auth_remote_datasource.dart';
import 'package:story_app/data/model/response/response_model.dart';

class RegisterAuthProvider extends ChangeNotifier {
  final StoryAuthRemoteDataSource _dataSource;

  RegisterAuthProvider(this._dataSource);

  ResponseModel? _responseModel;
  bool _isLoading = false;
  String? _error;
  String _username = '';
  String _email = '';
  String _password = '';
  String _passwordRepeat = '';

  ResponseModel? get responseModel => _responseModel;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get passwordRepeat => _passwordRepeat;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setPasswordRepeat(String value) {
    _passwordRepeat = value;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      if (_password != _passwordRepeat) {
        throw Exception(context.l10n.errorDontMatchPass);
      }
      final result = await _dataSource.register(
        email: _email,
        username: _username,
        password: _password,
      );
      _responseModel = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
