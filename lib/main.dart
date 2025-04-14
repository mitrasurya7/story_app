import 'package:flutter/material.dart';
import 'package:story_app/config/route/route_config.dart';
import 'package:story_app/config/theme/theme_provider.dart';
import 'package:story_app/core/common/localization.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/core/constants/app_string.dart';
import 'package:provider/provider.dart';
import 'package:story_app/features/localization/provider/localization_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocalizationProvider()),
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
          initialRoute: AppRouteName.home,
          onGenerateRoute: RouteConfig.onGenerateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localizationProvider.locale,
        );
      },
    );
  }
}
