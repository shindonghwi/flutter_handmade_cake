import 'package:handmade_cake/data/models/order/RequestOrderIndentDecoration.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../presentation/utils/StringUtil.dart';

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

  RequestOrderIndentCake copyWith({
    String? size,
    String? sheet,
    String? taste,
    String? jam,
    String? imagePath,
    List<RequestOrderIndentDecoration>? decorations,
  }) {
    return RequestOrderIndentCake(
      size: size ?? this.size,
      sheet: sheet ?? this.sheet,
      taste: taste ?? this.taste,
      jam: jam ?? this.jam,
      imagePath: imagePath ?? this.imagePath,
      decorations: decorations ?? this.decorations,
    );
  }

  factory RequestOrderIndentCake.fromJson(Map<String, dynamic> json) => _$RequestOrderIndentCakeFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOrderIndentCakeToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
