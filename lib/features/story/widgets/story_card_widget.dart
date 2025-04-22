import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:story_app/features/story/widgets/description_widget.dart';
import 'package:story_app/features/story/widgets/rounded_image.dart';
import 'package:story_app/features/story/widgets/user_info_widget.dart';

String formatDate(String dateStr) {
  final date = DateTime.parse(dateStr);
  return DateFormat('dd MMM yyyy • HH:mm').format(date);
}

class StoryCardWidget extends StatelessWidget {
  final Map<String, dynamic> story;
  const StoryCardWidget({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    final name = story['name'] ?? 'User';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedImage(imageUrl: story['photoUrl']),
          UserInfoWidget(
            name: name,
            initial: initial,
            dateFormatted: formatDate(story['createdAt']),
          ),
          DescriptionWidget(description: story['description']),
        ],
      ),
    );
  }
}
