import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/constants/app_route_name.dart';
import 'package:story_app/core/widgets/custom_text_field.dart';
import 'package:story_app/features/story/provider/post_story_provider.dart';

class PostStoryScreen extends StatelessWidget {
  const PostStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storyProvider = Provider.of<PostStoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Story")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Preview Gambar
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[300],
                  ),
                  child:
                      storyProvider.imageFile != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              storyProvider.imageFile!,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          )
                          : const Center(
                            child: Icon(
                              Icons.image,
                              size: 80,
                              color: Colors.grey,
                            ),
                          ),
                ),
                const SizedBox(height: 24),

                // Tombol pilih gambar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: storyProvider.pickFromGallery,
                      icon: const Icon(Icons.photo),
                      label: const Text("From Gallery"),
                    ),
                    ElevatedButton.icon(
                      onPressed: storyProvider.pickFromCamera,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("From Camera"),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'description',
                  icon: Icons.description,
                  onChanged: storyProvider.setDescription,
                ),
                SizedBox(height: 12),
                CustomTextField(
                  label: "Iat",
                  onChanged: storyProvider.setIat,
                  icon: Icons.my_location,
                ),
                SizedBox(height: 12),
                CustomTextField(
                  label: 'Ion',
                  onChanged: storyProvider.setIon,
                  icon: Icons.my_location,
                ),
                const SizedBox(height: 12),
                // Tombol Upload
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          storyProvider.isLoading
                              ? null
                              : () async {
                                await storyProvider.postStory(
                                  description: storyProvider.description,
                                  iat: storyProvider.iat,
                                  ion: storyProvider.ion,
                                );

                                if (storyProvider.error != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(storyProvider.error!),
                                    ),
                                  );
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRouteName.home,
                                    (Route<dynamic> route) => false,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        storyProvider.message ??
                                            "Story Uploaded!",
                                      ),
                                    ),
                                  );
                                }
                              },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child:
                          storyProvider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Upload Story"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
