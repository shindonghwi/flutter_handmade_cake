import 'package:handmade_cake/data/models/order/RequestOrderIndentCake.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentMessage.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentPrice.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentReceiver.dart';
import 'package:handmade_cake/presentation/utils/StringUtil.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RequestOrderIndentModel.g.dart';

@JsonSerializable()
class RequestOrderIndentModel {
  final RequestOrderIndentMessage message;
  final RequestOrderIndentReceiver receiver;
  final RequestOrderIndentPrice price;
  final RequestOrderIndentCake cake;
  final String payment;

  RequestOrderIndentModel({
    required this.message,
    required this.receiver,
    required this.price,
    required this.cake,
    required this.payment,
  });

  RequestOrderIndentModel copyWith({
    RequestOrderIndentMessage? message,
    RequestOrderIndentReceiver? receiver,
    RequestOrderIndentPrice? price,
    RequestOrderIndentCake? cake,
    String? payment,
  }) {
    return RequestOrderIndentModel(
      message: message ?? this.message,
      receiver: receiver ?? this.receiver,
      price: price ?? this.price,
      cake: cake ?? this.cake,
      payment: payment ?? this.payment,
    );
  }

  factory RequestOrderIndentModel.fromJson(Map<String, dynamic> json) => _$RequestOrderIndentModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequestOrderIndentModelToJson(this);

  @override
  String toString() {
    return StringUtil.convertPrettyJson(toJson());
  }
}