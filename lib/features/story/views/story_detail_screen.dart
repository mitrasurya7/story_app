import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/common/localization.dart';
import 'package:story_app/core/utils/date_formatter.dart';
import 'package:story_app/core/widgets/scaffold_mgs_widget.dart';
import 'package:story_app/features/story/provider/story_detail_provider.dart';
import 'package:story_app/features/story/widgets/rounded_image.dart';

class StoryDetailScreen extends StatefulWidget {
  final String name;
  final String id;

  const StoryDetailScreen({super.key, required this.name, required this.id});

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StoryDetailProvider>(
        context,
        listen: false,
      ).getStoryDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.appBarDetail(widget.name))),
      body: Consumer<StoryDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return ScaffoldMsg(message: provider.error!);
          }

          final story = provider.storyResult;
          if (story == null) {
            return const ScaffoldMsg(message: 'Story not found.');
          }

          return _StoryContent(story: story);
        },
      ),
    );
  }
}

class _StoryContent extends StatelessWidget {
  final dynamic story; // Replace with actual model

  const _StoryContent({required this.story});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - kToolbarHeight - 32,
        ),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (story.photoUrl.isNotEmpty)
                RoundedImage(imageUrl: story.photoUrl),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.name,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      story.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormatter.formatToLocalFullDate(
                              context,
                              story.createdAt,
                            ),
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
