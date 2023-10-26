import 'package:json_annotation/json_annotation.dart';

part 'ResponseOrderImageModel.g.dart';

@JsonSerializable()
class ResponseOrderImageModel {
  final String imagePath;

  ResponseOrderImageModel({
    required this.imagePath,
  });

  factory ResponseOrderImageModel.fromJson(Map<String, dynamic> json) => _$ResponseOrderImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseOrderImageModelToJson(this);
}