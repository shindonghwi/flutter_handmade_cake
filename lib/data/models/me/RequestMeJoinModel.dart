import 'package:json_annotation/json_annotation.dart';

part 'RequestMeJoinModel.g.dart';

@JsonSerializable()
class RequestMeJoinModel {
  final String email;
  final String password;

  RequestMeJoinModel({
    required this.email,
    required this.password,
  });

  factory RequestMeJoinModel.fromJson(Map<String, dynamic> json) => _$RequestMeJoinModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestMeJoinModelToJson(this);
}