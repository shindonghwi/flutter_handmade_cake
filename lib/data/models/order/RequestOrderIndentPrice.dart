import 'package:json_annotation/json_annotation.dart';

import '../../../presentation/utils/StringUtil.dart';

part 'RequestOrderIndentPrice.g.dart';

@JsonSerializable()
class RequestOrderIndentPrice {
  final int total;

  RequestOrderIndentPrice({
    required this.total,
  });

  RequestOrderIndentPrice copyWith({
    int? total,
  }) {
    return RequestOrderIndentPrice(
      total: total ?? this.total,
    );
  }

  factory RequestOrderIndentPrice.fromJson(Map<String, dynamic> json) => _$RequestOrderIndentPriceFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOrderIndentPriceToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
