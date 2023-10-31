import 'package:json_annotation/json_annotation.dart';

import '../../../presentation/utils/StringUtil.dart';

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

  RequestOrderIndentMessage copyWith({
    String? reason,
    String? request,
    String? memo,
  }) {
    return RequestOrderIndentMessage(
      reason: reason ?? this.reason,
      request: request ?? this.request,
      memo: memo ?? this.memo,
    );
  }

  factory RequestOrderIndentMessage.fromJson(Map<String, dynamic> json) => _$RequestOrderIndentMessageFromJson(json);
  Map<String, dynamic> toJson() => _$RequestOrderIndentMessageToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}