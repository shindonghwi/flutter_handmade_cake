import 'package:handmade_cake/data/models/order/RequestOrderIndentDecoration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RequestOrderIndentCake.g.dart';

@JsonSerializable()
class RequestOrderIndentCake {
  final String size;
  final String sheet;
  final String taste;
  final String jam;
  final String imagePath;
  final List<RequestOrderIndentDecoration> decorations;

  RequestOrderIndentCake({
    required this.size,
    required this.sheet,
    required this.taste,
    required this.jam,
    required this.imagePath,
    required this.decorations,
  });

  factory RequestOrderIndentCake.fromJson(Map<String, dynamic> json) => _$RequestOrderIndentCakeFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOrderIndentCakeToJson(this);
}
