import 'package:flutter/material.dart';
import 'package:story_app/config/route/route_config.dart';
import 'package:story_app/config/theme/theme_provider.dart';
import 'package:story_app/core/common/localization.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/core/constants/app_string.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/datasources/local/auth_local_datasource.dart';
import 'package:story_app/data/datasources/remote/story_auth_remote_datasource.dart';
import 'package:story_app/data/datasources/remote/story_remote_datasource.dart';
import 'package:story_app/features/auth/provider/auth_provider.dart';
import 'package:story_app/features/auth/provider/register_auth_provider.dart';
import 'package:story_app/features/localization/provider/localization_provider.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/features/story/provider/post_story_provider.dart';
import 'package:story_app/features/splash/provider/splash_provider.dart';
import 'package:story_app/features/story/provider/story_provider.dart';
import 'package:story_app/features/story/provider/story_detail_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final client = http.Client();
  final localDataSource = AuthLocalDataSource();
  final remoteDataSource = StoryAuthRemoteDataSource(client);
  final storyDataSource = StoryRemoteDataSource(client);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) =>
                  LocalizationProvider(localDataSource: localDataSource)
                    ..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(remoteDataSource, localDataSource),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterAuthProvider(remoteDataSource),
        ),
        ChangeNotifierProvider(
          create: (context) => StoryProvider(storyDataSource, localDataSource),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  StoryDetailProvider(storyDataSource, localDataSource),
        ),
        ChangeNotifierProvider(
          create:
              (context) => PostStoryProvider(localDataSource, storyDataSource),
        ),
        ChangeNotifierProvider(
          create: (context) => SplashProvider(localDataSource),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, _) {
        return MaterialApp(
          title: AppString.appName,
          theme: PlatformTheme.getTheme(),
          initialRoute: AppRouteName.splash,
          onGenerateRoute: RouteConfig.onGenerateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localizationProvider.locale,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
