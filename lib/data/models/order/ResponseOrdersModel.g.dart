// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseOrdersModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseOrdersModel _$ResponseOrdersModelFromJson(Map<String, dynamic> json) =>
    ResponseOrdersModel(
      status: json['status'] as String,
      price: RequestOrderIndentPrice.fromJson(
          json['price'] as Map<String, dynamic>),
      cake: ResponseOrdersCake.fromJson(json['cake'] as Map<String, dynamic>),
      message: RequestOrderIndentMessage.fromJson(
          json['message'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : RequestOrderIndentReceiver.fromJson(
              json['receiver'] as Map<String, dynamic>),
      createdDate: json['createdDate'] as String,
      orderId: json['orderId'] as int,
    );

Map<String, dynamic> _$ResponseOrdersModelToJson(
        ResponseOrdersModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'price': instance.price,
      'cake': instance.cake,
      'message': instance.message,
      'receiver': instance.receiver,
      'createdDate': instance.createdDate,
      'orderId': instance.orderId,
    };
