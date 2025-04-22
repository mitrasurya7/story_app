import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  final bool error;
  final String message;

  ResponseModel({required this.error, required this.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
