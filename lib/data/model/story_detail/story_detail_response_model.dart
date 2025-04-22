import 'package:json_annotation/json_annotation.dart';
import 'package:story_app/data/model/story/story_response_model.dart';

part 'story_detail_response_model.g.dart';

@JsonSerializable()
class StoryDetailResponseModel {
  final bool error;
  final String message;
  final StoryResult story;

  StoryDetailResponseModel({
    required this.error,
    required this.message,
    required this.story,
  });

  factory StoryDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryDetailResponseModelToJson(this);
}
