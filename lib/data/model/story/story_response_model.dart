import 'package:json_annotation/json_annotation.dart';

part 'story_response_model.g.dart';

@JsonSerializable()
class StoryResponseModel {
  final bool error;
  final String message;
  final List<StoryResult> listStory;

  StoryResponseModel({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResponseModelToJson(this);
}

@JsonSerializable()
class StoryResult {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double? lat;
  final double? lon;

  StoryResult({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    this.lat,
    this.lon,
  });

  factory StoryResult.fromJson(Map<String, dynamic> json) =>
      _$StoryResultFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResultToJson(this);
}
