import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/features/story/provider/story_provider.dart';
import 'package:story_app/features/story/widgets/story_card_widget.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<StoryProvider>(context, listen: false).getStoryList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        }

        final stories = provider.listStoryResult ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            return GestureDetector(
              onTap:
                  () => {
                    Navigator.pushNamed(
                      context,
                      AppRouteName.detail,
                      arguments: story,
                    ),
                  },
              child: StoryCardWidget(
                story: {
                  'id': story.id,
                  'name': story.name,
                  'description': story.description,
                  'photoUrl': story.photoUrl,
                  'createdAt': story.createdAt,
                },
              ),
            );
          },
        );
      },
    );
  }
}
