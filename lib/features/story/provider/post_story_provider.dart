import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/data/datasources/local/auth_local_datasource.dart';
import 'package:story_app/data/datasources/remote/story_remote_datasource.dart';

class PostStoryProvider extends ChangeNotifier {
  final AuthLocalDataSource _localDataSource;
  final StoryRemoteDataSource _storyDataSource;

  PostStoryProvider(this._localDataSource, this._storyDataSource);

  String? _message;
  bool _isLoading = false;
  String? _error;
  File? _imageFile;
  String _description = '';
  double _iat = 0.0;
  double _ion = 0.0;

  final ImagePicker _picker = ImagePicker();

  // Getters
  String? get message => _message;
  bool get isLoading => _isLoading;
  String? get error => _error;
  File? get imageFile => _imageFile;
  String get description => _description;
  double get iat => _iat;
  double get ion => _ion;

  //--setter

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void setIat(String value) {
    _iat = double.tryParse(value) ?? 0.0;
    notifyListeners();
  }

  void setIon(String value) {
    _ion = double.tryParse(value) ?? 0.0;
    notifyListeners();
  }

  // --- Image picking ---
  Future<void> pickFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> pickFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  void clearImage() {
    _imageFile = null;
    notifyListeners();
  }

  // --- Post story ---
  Future<void> postStory({
    required String description,
    required double iat,
    required double ion,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _localDataSource.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token tidak ditemukan');
      }

      if (_imageFile == null) {
        throw Exception('Gambar belum dipilih');
      }

      final response = await _storyDataSource.postStory(
        description: description,
        photo: _imageFile!,
        iat: iat,
        ion: ion,
        token: token,
      );

      _message = response.message;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
