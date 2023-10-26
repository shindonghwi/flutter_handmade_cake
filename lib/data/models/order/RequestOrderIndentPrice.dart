import 'package:json_annotation/json_annotation.dart';

part 'RequestOrderIndentPrice.g.dart';

@JsonSerializable()
class RequestOrderIndentPrice {
  final int total;

  RequestOrderIndentPrice({
    required this.total,
  });

  factory RequestOrderIndentPrice.fromJson(Map<String, dynamic> json) => _$RequestOrderIndentPriceFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOrderIndentPriceToJson(this);
}
