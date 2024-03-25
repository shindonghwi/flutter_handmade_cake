import 'package:json_annotation/json_annotation.dart';

part 'ResponseOrderIndentModel.g.dart';

@JsonSerializable()
class ResponseOrderIndentModel {
  final int orderId;

  ResponseOrderIndentModel({
    required this.orderId,
  });

  factory ResponseOrderIndentModel.fromJson(Map<String, dynamic> json) => _$ResponseOrderIndentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseOrderIndentModelToJson(this);
}