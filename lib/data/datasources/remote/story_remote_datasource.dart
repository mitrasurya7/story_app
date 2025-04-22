import 'dart:convert';
import 'dart:io' as io; // untuk File di platform non-web
import 'package:http_parser/http_parser.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:story_app/core/constants/app_url.dart';
import 'package:story_app/data/model/response/response_model.dart';
import 'package:story_app/data/model/story/story_response_model.dart';
import 'package:story_app/data/model/story_detail/story_detail_response_model.dart';

class StoryRemoteDataSource {
  final http.Client client;

  StoryRemoteDataSource(this.client);

  Map<String, String> _headers(String token) => {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  Future<List<StoryResult>?> fetchStories(String token) async {
    try {
      final response = await client.get(
        Uri.parse(AppUrl.stories),
        headers: _headers(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final storyResponse = StoryResponseModel.fromJson(data);
        return storyResponse.listStory;
      } else {
        throw http.ClientException(
          'Failed to load stories: ${response.statusCode}',
          Uri.parse(AppUrl.stories),
        );
      }
    } catch (e) {
      throw Exception('Error fetching stories: $e');
    }
  }

  Future<StoryResult> fetchStoryDetail(String id, String token) async {
    final uri = Uri.parse('${AppUrl.stories}/$id');
    try {
      final response = await client.get(uri, headers: _headers(token));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final detailResponse = StoryDetailResponseModel.fromJson(data);
        return detailResponse.story;
      } else {
        throw http.ClientException(
          'Failed to load story detail: ${response.statusCode}',
          uri,
        );
      }
    } catch (e) {
      throw Exception('Error fetching story detail: $e');
    }
  }

  Future<ResponseModel> postStory({
    required String description,
    required dynamic photo, // bisa File (mobile) atau Uint8List (web)
    required double iat,
    required double ion,
    required String token,
  }) async {
    final uri = Uri.parse(AppUrl.stories);

    try {
      final request =
          http.MultipartRequest('POST', uri)
            ..headers['Authorization'] = 'Bearer $token'
            ..fields['description'] = description
            ..fields['lat'] = iat.toString()
            ..fields['lon'] = ion.toString();

      if (kIsWeb) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'photo',
            photo as List<int>,
            filename: 'upload.jpg',
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      } else {
        // Mobile/Desktop: gunakan File
        request.files.add(
          await http.MultipartFile.fromPath('photo', (photo as io.File).path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return ResponseModel.fromJson(data);
      } else {
        throw Exception('Failed to post story: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error posting story: $e');
    }
  }
}
