import 'package:json_annotation/json_annotation.dart';

part 'ResponseNoticeModel.g.dart';

@JsonSerializable()
class ResponseNoticeModel {
  final int noticeId;
  final String title;
  final String content;
  final String createdDate;

  ResponseNoticeModel({
    required this.noticeId,
    required this.title,
    required this.content,
    required this.createdDate,
  });

  factory ResponseNoticeModel.fromJson(Map<String, dynamic> json) => _$ResponseNoticeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseNoticeModelToJson(this);
}