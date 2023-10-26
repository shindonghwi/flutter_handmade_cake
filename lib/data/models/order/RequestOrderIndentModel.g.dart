// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestOrderIndentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestOrderIndentModel _$RequestOrderIndentModelFromJson(
        Map<String, dynamic> json) =>
    RequestOrderIndentModel(
      message: RequestOrderIndentMessage.fromJson(
          json['message'] as Map<String, dynamic>),
      receiver: RequestOrderIndentReceiver.fromJson(
          json['receiver'] as Map<String, dynamic>),
      price: RequestOrderIndentPrice.fromJson(
          json['price'] as Map<String, dynamic>),
      cake:
          RequestOrderIndentCake.fromJson(json['cake'] as Map<String, dynamic>),
      payment: json['payment'] as String,
    );

Map<String, dynamic> _$RequestOrderIndentModelToJson(
        RequestOrderIndentModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'receiver': instance.receiver,
      'price': instance.price,
      'cake': instance.cake,
      'payment': instance.payment,
    };
