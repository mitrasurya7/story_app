import 'package:flutter/material.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/features/home/widgets/app_bar_widget.dart';
import 'package:story_app/features/story/views/story_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: StoryScreen(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, AppRouteName.postStory);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
