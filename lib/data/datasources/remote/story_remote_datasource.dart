import 'package:http/http.dart' as http;
import 'package:story_app/core/constants/app_url.dart';

class StoryRemoteDataSource {
  final http.Client client;

  StoryRemoteDataSource(this.client);

  Future<String> fetchStories(String token) async {
    final response = await client.get(
      Uri.parse(AppUrl.stories),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load stories');
    }
  }
}
