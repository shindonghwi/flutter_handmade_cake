import 'package:json_annotation/json_annotation.dart';

import 'RequestOrderIndentPrice.dart';

part 'ResponseOrdersCake.g.dart';

@JsonSerializable()
class ResponseOrdersCake {
  final String size;
  final String sheet;
  final String taste;
  final String jam;
  final String imageUrl;
  final List<String> decorations;

  ResponseOrdersCake({
    required this.size,
    required this.sheet,
    required this.taste,
    required this.jam,
    required this.imageUrl,
    required this.decorations,
  });

  factory ResponseOrdersCake.fromJson(Map<String, dynamic> json) => _$ResponseOrdersCakeFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseOrdersCakeToJson(this);
}