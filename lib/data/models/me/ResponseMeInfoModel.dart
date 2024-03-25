import 'package:json_annotation/json_annotation.dart';

part 'ResponseMeInfoModel.g.dart';

@JsonSerializable()
class ResponseMeInfoModel {
  final String email;
  final int memberId;

  ResponseMeInfoModel({
    required this.email,
    required this.memberId,
  });

  factory ResponseMeInfoModel.fromJson(Map<String, dynamic> json) => _$ResponseMeInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMeInfoModelToJson(this);
}