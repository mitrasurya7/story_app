import 'package:flutter/material.dart';
import 'package:story_app/data/datasources/local/auth_local_datasource.dart';

class SplashProvider extends ChangeNotifier {
  final AuthLocalDataSource authLocalDataSource;

  SplashProvider(this.authLocalDataSource);

  bool _authResult = false;
  bool _isChecking = true;

  bool get authResult => _authResult;
  bool get isChecking => _isChecking;

  Future<void> checkToken() async {
    final token = await authLocalDataSource.getToken();
    _authResult = token != null;
    _isChecking = false;
    notifyListeners();
  }
}
