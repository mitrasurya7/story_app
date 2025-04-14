import 'package:flutter/material.dart';
import 'package:story_app/features/home/widgets/app_bar_widget.dart';
import 'package:story_app/features/home/widgets/story_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> stories = const [
    {
      "id": "story-wa6JXhXiIyLM-ZYZ",
      "name": "padli",
      "description": "inpo",
      "photoUrl":
          "https://story-api.dicoding.dev/images/stories/photos-1744605674146_e17427f1f79decff01b3.jpg",
      "createdAt": "2025-04-14T04:41:14.148Z",
    },
    {
      "id": "story-NYYKCOB2ltpvRjzC",
      "name": "Kentut jahanam",
      "description": "yamete",
      "photoUrl":
          "https://story-api.dicoding.dev/images/stories/photos-1744605252616_aca57c8795e7899ac71c.jpg",
      "createdAt": "2025-04-14T04:34:12.619Z",
    },
    {
      "id": "story-llrVg3IFrpd7hUgh",
      "name": "padli",
      "description": "heiehabjwhebskajs",
      "photoUrl":
          "https://story-api.dicoding.dev/images/stories/photos-1744604942457_2afaa55a91301718dbed.jpg",
      "createdAt": "2025-04-14T04:29:02.467Z",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return StoryCardWidget(story: stories[index]);
        },
      ),
    );
  }
}
