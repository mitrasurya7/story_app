import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/features/splash/provider/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    final splashProvider = context.read<SplashProvider>();
    await splashProvider.checkToken();

    if (splashProvider.authResult) {
      Navigator.pushReplacementNamed(context, AppRouteName.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRouteName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
