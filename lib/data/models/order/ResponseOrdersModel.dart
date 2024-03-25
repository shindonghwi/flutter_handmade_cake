import 'package:handmade_cake/data/models/order/RequestOrderIndentPrice.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentReceiver.dart';
import 'package:json_annotation/json_annotation.dart';

import 'RequestOrderIndentMessage.dart';
import 'ResponseOrdersCake.dart';

part 'ResponseOrdersModel.g.dart';

@JsonSerializable()
class ResponseOrdersModel {
  final String status;
  final RequestOrderIndentPrice price;
  final ResponseOrdersCake cake;
  final RequestOrderIndentMessage message;
  final RequestOrderIndentReceiver? receiver;
  final String createdDate;
  final int orderId;

  ResponseOrdersModel({
    required this.status,
    required this.price,
    required this.cake,
    required this.message,
    required this.receiver,
    required this.createdDate,
    required this.orderId,
  });

  factory ResponseOrdersModel.fromJson(Map<String, dynamic> json) => _$ResponseOrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseOrdersModelToJson(this);
}