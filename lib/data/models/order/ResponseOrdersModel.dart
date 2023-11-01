import 'package:json_annotation/json_annotation.dart';

import 'ResponseOrdersCake.dart';
import 'ResponseOrdersMessage.dart';
import 'ResponseOrdersPrice.dart';

part 'ResponseOrdersModel.g.dart';

@JsonSerializable()
class ResponseOrdersModel {
  final String status;
  final ResponseOrdersPrice price;
  final ResponseOrdersCake cake;
  final ResponseOrdersMessage message;
  final String createdDate;
  final int orderId;

  ResponseOrdersModel({
    required this.status,
    required this.price,
    required this.cake,
    required this.message,
    required this.createdDate,
    required this.orderId,
  });

  factory ResponseOrdersModel.fromJson(Map<String, dynamic> json) => _$ResponseOrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseOrdersModelToJson(this);
}