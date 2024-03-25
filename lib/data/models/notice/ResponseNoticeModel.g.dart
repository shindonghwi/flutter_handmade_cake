// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseNoticeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseNoticeModel _$ResponseNoticeModelFromJson(Map<String, dynamic> json) =>
    ResponseNoticeModel(
      noticeId: json['noticeId'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdDate: json['createdDate'] as String,
    );

Map<String, dynamic> _$ResponseNoticeModelToJson(
        ResponseNoticeModel instance) =>
    <String, dynamic>{
      'noticeId': instance.noticeId,
      'title': instance.title,
      'content': instance.content,
      'createdDate': instance.createdDate,
    };
