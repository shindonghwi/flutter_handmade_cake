import 'package:json_annotation/json_annotation.dart';

part 'RequestOrderIndentDecoration.g.dart';

@JsonSerializable()
class RequestOrderIndentDecoration {
  final String type;
  final int count;

  RequestOrderIndentDecoration({
    required this.type,
    required this.count,
  });

  RequestOrderIndentDecoration copyWith({
    String? type,
    int? count,
  }) {
    return RequestOrderIndentDecoration(
      type: type ?? this.type,
      count: count ?? this.count,
    );
  }

  factory RequestOrderIndentDecoration.fromJson(Map<String, dynamic> json) =>
      _$RequestOrderIndentDecorationFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOrderIndentDecorationToJson(this);
}
