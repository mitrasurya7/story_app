// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      loginResult: LoginResult.fromJson(
        json['loginResult'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'loginResult': instance.loginResult,
    };

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
  userId: json['userId'] as String,
  name: json['name'] as String,
  token: json['token'] as String,
);

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'token': instance.token,
    };
