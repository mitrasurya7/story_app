import 'package:flutter/material.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/data/model/story/story_response_model.dart';
import 'package:story_app/features/auth/views/login_screen.dart';
import 'package:story_app/features/auth/views/register_screen.dart';
import 'package:story_app/features/home/views/home_screen.dart';
import 'package:story_app/features/story/views/post_story_screen.dart';
import 'package:story_app/features/splash/views/splash_screen.dart';
import 'package:story_app/features/story/views/story_detail_screen.dart';

class RouteConfig {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRouteName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRouteName.detail:
        final args = settings.arguments as StoryResult;
        return MaterialPageRoute(
          builder: (context) {
            return StoryDetailScreen(name: args.name, id: args.id);
          },
        );
      case AppRouteName.postStory:
        return MaterialPageRoute(builder: (context) => const PostStoryScreen());
      case AppRouteName.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case AppRouteName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
