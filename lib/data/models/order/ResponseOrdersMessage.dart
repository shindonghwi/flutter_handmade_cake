import 'package:json_annotation/json_annotation.dart';

import 'RequestOrderIndentPrice.dart';

part 'ResponseOrdersMessage.g.dart';

@JsonSerializable()
class ResponseOrdersMessage {
  final String reason;

  ResponseOrdersMessage({
    required this.reason,
  });

  factory ResponseOrdersMessage.fromJson(Map<String, dynamic> json) => _$ResponseOrdersMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseOrdersMessageToJson(this);
}