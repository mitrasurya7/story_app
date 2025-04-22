import 'package:flutter/material.dart';
import 'package:story_app/data/datasources/local/auth_local_datasource.dart';
import 'package:story_app/data/datasources/remote/story_remote_datasource.dart';
import 'package:story_app/data/model/story/story_response_model.dart';

class StoryProvider extends ChangeNotifier {
  final AuthLocalDataSource localDataSource;
  final StoryRemoteDataSource storyDataSource;

  StoryProvider(this.storyDataSource, this.localDataSource);

  List<StoryResult>? _listStoryResult;
  bool _isLoading = false;
  String? _error;

  List<StoryResult>? get listStoryResult => _listStoryResult;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getStoryList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await storyDataSource.fetchStories(
        await localDataSource.getToken() as String,
      );
      _listStoryResult = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
