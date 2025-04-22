import 'package:flutter/material.dart';
import 'package:story_app/data/datasources/local/auth_local_datasource.dart';
import 'package:story_app/data/datasources/remote/story_remote_datasource.dart';
import 'package:story_app/data/model/story/story_response_model.dart';

class StoryDetailProvider extends ChangeNotifier {
  final AuthLocalDataSource _localDataSource;
  final StoryRemoteDataSource _storyDataSource;

  StoryDetailProvider(this._storyDataSource, this._localDataSource);

  StoryResult? _storyResult;
  bool _isLoading = false;
  String? _error;

  StoryResult? get storyResult => _storyResult;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getStoryDetail(String id) async {
    _setLoading(true);
    _error = null;

    try {
      final token = await _localDataSource.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token tidak ditemukan');
      }

      final result = await _storyDataSource.fetchStoryDetail(id, token);
      _storyResult = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
