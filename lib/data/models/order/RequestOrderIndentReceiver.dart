import 'package:json_annotation/json_annotation.dart';

import '../../../presentation/utils/StringUtil.dart';

part 'RequestOrderIndentReceiver.g.dart';

@JsonSerializable()
class RequestOrderIndentReceiver {
  final String name;
  final String phone;
  final String address;

  RequestOrderIndentReceiver({
    required this.name,
    required this.phone,
    required this.address,
  });

  RequestOrderIndentReceiver copyWith({
    String? name,
    String? phone,
    String? address,
  }) {
    return RequestOrderIndentReceiver(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  factory RequestOrderIndentReceiver.fromJson(Map<String, dynamic> json) => _$RequestOrderIndentReceiverFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOrderIndentReceiverToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}
