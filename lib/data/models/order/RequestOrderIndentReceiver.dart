import 'package:json_annotation/json_annotation.dart';

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

  factory RequestOrderIndentReceiver.fromJson(Map<String, dynamic> json) => _$RequestOrderIndentReceiverFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOrderIndentReceiverToJson(this);
}
