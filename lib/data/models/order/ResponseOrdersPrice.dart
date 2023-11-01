import 'package:json_annotation/json_annotation.dart';

import 'RequestOrderIndentPrice.dart';

part 'ResponseOrdersPrice.g.dart';

@JsonSerializable()
class ResponseOrdersPrice {
  final int total;

  ResponseOrdersPrice({
    required this.total,
  });

  factory ResponseOrdersPrice.fromJson(Map<String, dynamic> json) => _$ResponseOrdersPriceFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseOrdersPriceToJson(this);
}