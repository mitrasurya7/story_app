// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryResponseModel _$StoryResponseModelFromJson(Map<String, dynamic> json) =>
    StoryResponseModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory:
          (json['listStory'] as List<dynamic>)
              .map((e) => StoryResult.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$StoryResponseModelToJson(StoryResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };

StoryResult _$StoryResultFromJson(Map<String, dynamic> json) => StoryResult(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  photoUrl: json['photoUrl'] as String,
  createdAt: json['createdAt'] as String,
  lat: (json['lat'] as num?)?.toDouble(),
  lon: (json['lon'] as num?)?.toDouble(),
);

Map<String, dynamic> _$StoryResultToJson(StoryResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt,
      'lat': instance.lat,
      'lon': instance.lon,
    };
