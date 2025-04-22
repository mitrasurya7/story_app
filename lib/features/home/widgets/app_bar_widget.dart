import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/common/localization.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/features/auth/provider/auth_provider.dart';
import 'package:story_app/features/story/widgets/lang_switcher_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return AppBar(
      title: Text('📸 ${AppLocalizations.of(context)!.title}'),
      actions: [
        LangSwitcherWidget(context: context),
        IconButton(
          onPressed: () {
            authProvider.logout();
            Navigator.pushReplacementNamed(context, AppRouteName.login);
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
