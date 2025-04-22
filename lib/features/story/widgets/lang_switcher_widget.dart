import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/features/localization/provider/localization_provider.dart';

class LangSwitcherWidget extends StatelessWidget {
  final BuildContext context;
  const LangSwitcherWidget({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language),
      onSelected: (Locale locale) {
        context.read<LocalizationProvider>().setLocale(locale);
      },
      itemBuilder:
          (context) => [
            const PopupMenuItem(value: Locale('en'), child: Text('English')),
            const PopupMenuItem(
              value: Locale('id'),
              child: Text('Bahasa Indonesia'),
            ),
          ],
    );
  }
}
