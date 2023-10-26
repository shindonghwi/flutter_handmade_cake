// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestOrderIndentMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestOrderIndentMessage _$RequestOrderIndentMessageFromJson(
        Map<String, dynamic> json) =>
    RequestOrderIndentMessage(
      reason: json['reason'] as String,
      request: json['request'] as String,
      memo: json['memo'] as String,
    );

Map<String, dynamic> _$RequestOrderIndentMessageToJson(
        RequestOrderIndentMessage instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'request': instance.request,
      'memo': instance.memo,
    };
