import 'package:flutter/material.dart';
import 'package:story_app/core/common/localization.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/features/home/widgets/lang_switcher_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('📸 ${AppLocalizations.of(context)!.title}'),
      backgroundColor: Color(0xFF3C78D8),
      foregroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: true,
      actions: [
        LangSwitcherWidget(context: context),
        IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRouteName.login);
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
