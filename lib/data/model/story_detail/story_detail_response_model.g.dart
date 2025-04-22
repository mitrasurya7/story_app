// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryDetailResponseModel _$StoryDetailResponseModelFromJson(
  Map<String, dynamic> json,
) => StoryDetailResponseModel(
  error: json['error'] as bool,
  message: json['message'] as String,
  story: StoryResult.fromJson(json['story'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StoryDetailResponseModelToJson(
  StoryDetailResponseModel instance,
) => <String, dynamic>{
  'error': instance.error,
  'message': instance.message,
  'story': instance.story,
};
