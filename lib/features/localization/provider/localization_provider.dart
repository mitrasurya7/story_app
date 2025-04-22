import 'package:flutter/material.dart';
import 'package:story_app/data/datasources/local/auth_local_datasource.dart';

class LocalizationProvider extends ChangeNotifier {
  final AuthLocalDataSource localDataSource;

  Locale _locale = const Locale('en'); // Default

  Locale get locale => _locale;

  LocalizationProvider({required this.localDataSource});

  Future<void> init() async {
    final savedLocaleCode = await localDataSource.getLanguange();
    if (savedLocaleCode != null) {
      _locale = Locale(savedLocaleCode);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale != locale) {
      _locale = locale;
      await localDataSource.setLanguage(locale.languageCode);
      notifyListeners();
    }
  }
}
