import 'package:json_annotation/json_annotation.dart';

part 'RequestOrderIndentMessage.g.dart';

@JsonSerializable()
class RequestOrderIndentMessage {
  final String reason;
  final String request;
  final String memo;

  RequestOrderIndentMessage({
    required this.reason,
    required this.request,
    required this.memo,
  });

  factory RequestOrderIndentMessage.fromJson(Map<String, dynamic> json) => _$RequestOrderIndentMessageFromJson(json);
  Map<String, dynamic> toJson() => _$RequestOrderIndentMessageToJson(this);
}