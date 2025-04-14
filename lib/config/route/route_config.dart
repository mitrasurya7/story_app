import 'package:flutter/material.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/features/auth/views/login_screen.dart';
import 'package:story_app/features/auth/views/register_screen.dart';
import 'package:story_app/features/home/views/home_screen.dart';

class RouteConfig {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRouteName.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case AppRouteName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
